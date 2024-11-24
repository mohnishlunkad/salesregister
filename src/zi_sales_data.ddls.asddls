@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_SALES_DATA
  as select from    I_BillingDocumentItemBasic     as BillingItem
    left outer join I_BillingDocumentPartnerBasic  as PartnerBillToParty  on  PartnerBillToParty.BillingDocument = BillingItem.BillingDocument
                                                                          and PartnerBillToParty.PartnerFunction = 'RE'
    left outer join I_Customer                     as BillToParty         on BillToParty.Customer = PartnerBillToParty.Customer

    left outer join I_BillingDocumentPartnerBasic  as PartnerShipToParty  on  PartnerShipToParty.BillingDocument = BillingItem.BillingDocument
                                                                          and PartnerShipToParty.PartnerFunction = 'WE'

    left outer join I_ProductPlantIntlTrd          as ProductPlantIntlTrd on  ProductPlantIntlTrd.Product = BillingItem.Product
                                                                          and ProductPlantIntlTrd.Plant   = BillingItem.Plant

    left outer join I_BillingDocItemPrcgElmntBasic as CGST                on  CGST.BillingDocument     = BillingItem.BillingDocument
                                                                          and CGST.BillingDocumentItem = BillingItem.BillingDocumentItem
                                                                          and CGST.ConditionType       = 'JOCG'

    left outer join I_BillingDocItemPrcgElmntBasic as SGST                on  SGST.BillingDocument     = BillingItem.BillingDocument
                                                                          and SGST.BillingDocumentItem = BillingItem.BillingDocumentItem
                                                                          and SGST.ConditionType       = 'JOSG'

    left outer join I_BillingDocItemPrcgElmntBasic as IGST                on  IGST.BillingDocument     = BillingItem.BillingDocument
                                                                          and IGST.BillingDocumentItem = BillingItem.BillingDocumentItem
                                                                          and IGST.ConditionType       = 'JOIG'

    left outer join I_BillingDocItemPrcgElmntBasic as UnitRate            on  UnitRate.BillingDocument     = BillingItem.BillingDocument
                                                                          and UnitRate.BillingDocumentItem = BillingItem.BillingDocumentItem
                                                                          and UnitRate.ConditionType       = 'PPR0'

    left outer join I_BillingDocItemPrcgElmntBasic as AdvanceAmount       on  AdvanceAmount.BillingDocument     = BillingItem.BillingDocument
                                                                          and AdvanceAmount.BillingDocumentItem = BillingItem.BillingDocumentItem
                                                                          and AdvanceAmount.ConditionType       = 'ZADV'

    left outer join I_BillingDocItemPrcgElmntBasic as Retention1          on  Retention1.BillingDocument     = BillingItem.BillingDocument
                                                                          and Retention1.BillingDocumentItem = BillingItem.BillingDocumentItem
                                                                          and Retention1.ConditionType       = 'ZRT1'

    left outer join I_BillingDocItemPrcgElmntBasic as Retention2          on  Retention2.BillingDocument     = BillingItem.BillingDocument
                                                                          and Retention2.BillingDocumentItem = BillingItem.BillingDocumentItem
                                                                          and Retention2.ConditionType       = 'ZRT2'

    left outer join I_BillingDocItemPrcgElmntBasic as Retention3          on  Retention3.BillingDocument     = BillingItem.BillingDocument
                                                                          and Retention3.BillingDocumentItem = BillingItem.BillingDocumentItem
                                                                          and Retention3.ConditionType       = 'ZRT3'

    left outer join I_BillingDocItemPrcgElmntBasic as Retention4          on  Retention4.BillingDocument     = BillingItem.BillingDocument
                                                                          and Retention4.BillingDocumentItem = BillingItem.BillingDocumentItem
                                                                          and Retention4.ConditionType       = 'ZRT4'
    left outer join I_EnterpriseProjectElement_2   as Wbs                 on Wbs.WBSElementInternalID = BillingItem.WBSElementInternalID

    left outer join I_EnterpriseProject            as Project             on Project.ProjectInternalID = Wbs.ProjectInternalID

    left outer join I_BillingDocumentBasic         as BillingHeader       on BillingHeader.BillingDocument = BillingItem.BillingDocument

    left outer join I_OperationalAcctgDocItem      as AccDoc              on  AccDoc.AccountingDocument   = BillingHeader.AccountingDocument
                                                                          and AccDoc.FiscalYear           = BillingHeader.FiscalYear
                                                                          and AccDoc.CompanyCode          = BillingHeader.CompanyCode
                                                                          and AccDoc.FinancialAccountType = 'D'

    left outer join I_GLAccountLineItem            as GLItem              on  GLItem.AccountingDocument = AccDoc.ClearingJournalEntry
                                                                          and GLItem.FiscalYear         = AccDoc.FiscalYear
                                                                          and GLItem.CompanyCode        = AccDoc.CompanyCode
                                                                          and GLItem.Ledger             = '0L'
                                                                          and GLItem.GLAccount          = AccDoc.GLAccount
    left outer join I_DeliveryDocument             as DeliveryDocument    on DeliveryDocument.DeliveryDocument = BillingItem.ReferenceSDDocument
    left outer join I_Customer                     as ShipToParty         on ShipToParty.Customer = DeliveryDocument.ShipToParty
    left outer join I_SalesOrder                   as SalesOrder          on SalesOrder.SalesOrder = BillingItem.SalesDocument
    left outer join I_OperationalAcctgDocItem      as AccDocItem          on AccDocItem.BillingDocument = BillingItem.BillingDocument
    left outer join I_IN_BusinessPlaceTaxDetail    as BusPlace            on  BusPlace.CompanyCode   = BillingHeader.CompanyCode
                                                                          and BusPlace.BusinessPlace = AccDocItem.BusinessPlace

{
  key BillingItem.BillingDocument,
  key BillingItem.BillingDocumentItem,
      BillingItem._BillingDocumentBasic.BillingDocumentDate,
      @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      BillingItem.BillingQuantity,
      BillingItem.BillingQuantityUnit,
      BillingItem._BillingDocumentBasic.FiscalYear,
      BillingItem._BillingDocumentBasic.AccountingDocument,
      BillingItem._BillingDocumentBasic.SoldToParty,
      BillingItem._BillingDocumentBasic._SoldToParty.CustomerName                                                             as SoldToPartyName,
      BillingItem._BillingDocumentBasic.PayerParty,
      BillingItem._BillingDocumentBasic._PayerParty.CustomerName                                                              as PayerPartyName,

      PartnerBillToParty.Customer                                                                                             as BillToParty,
      BillToParty.CustomerName                                                                                                as BillToPartyName,
      BillToParty.TaxNumber3                                                                                                  as CustomerGST,
      BillingItem._BillingDocumentBasic._Region[ Country = 'IN' ]._RegionText[ Language = 'E' ].RegionName,
      BillingItem._BillingDocumentBasic._Country._Text[ Language = 'E' ].CountryName,

      DeliveryDocument.ShipToParty                                                                                            as ShipToParty,
      ShipToParty.CustomerName                                                                                                as ShipToPartyName,
      BillingItem._BillingDocumentBasic.TransactionCurrency,
      concat(BillingItem._BillingDocumentBasic.IncotermsClassification, BillingItem._BillingDocumentBasic.IncotermsLocation1) as IncoTerms,
      BillingItem._BillingDocumentBasic.CustomerPaymentTerms,
      BillingItem._BillingDocumentBasic.CreatedByUser,
      BillingItem.PricingDate,
      BillingItem.OrganizationDivision,
      BillingItem.Product,
      BillingItem._ProductText[ Language = 'E' ].ProductName,
      BillingItem._BillingDocumentBasic.BillingDocumentType,

      case when BillingItem.ReferenceSDDocumentCategory = 'J'
        then BillingItem.ReferenceSDDocument
        else ''
        end                                                                                                                   as OBD,

      case when BillingItem.ReferenceSDDocumentCategory = 'J'
      then BillingItem._ReferenceDeliveryDocumentItem._DeliveryDocument.ActualGoodsMovementDate
      else cast('' as abap.dats)
      end                                                                                                                     as OBDDate,

      case when BillingItem.SalesSDDocumentCategory = 'C'
        then BillingItem.SalesDocument
        else ''
        end                                                                                                                   as SalesOrderNo,

      case when BillingItem.SalesSDDocumentCategory = 'C'
      then SalesOrder.SalesOrderDate
      else cast('' as abap.dats)
      end                                                                                                                     as SalesOrderDate,


      ProductPlantIntlTrd.ConsumptionTaxCtrlCode                                                                              as HSNSac,
      BillingItem.ProfitCenter,
      BusPlace.IN_GSTIdentificationNumber                                                                                     as SupplierGSTIN,
      SalesOrder.PurchaseOrderByCustomer,

      cast(BillingItem.NetAmount  as abap.dec(13,2))                                                                          as NetAmount,

      cast(CGST.ConditionRateValue as abap.dec(13,2))                                                                         as CGSTRate,
      cast(CGST.ConditionAmount as abap.dec(13,3))                                                                            as CGSTAmount,

      cast(SGST.ConditionRateValue as abap.dec(13,2))                                                                         as SGSTRate,
      cast(SGST.ConditionAmount as abap.dec(13,3))                                                                            as SGSTAmount,

      cast(IGST.ConditionRateValue as abap.dec(13,2))                                                                         as IGSTRate,
      cast(IGST.ConditionAmount as abap.dec(13,3))                                                                            as IGSTAmount,

      cast(UnitRate.ConditionAmount as abap.dec(13,3))                                                                        as UnitRate,

      cast(AdvanceAmount.ConditionAmount as abap.dec(13,3))                                                                   as AdvanceAmount,

      cast(Retention1.ConditionRateValue as abap.dec(13,2))                                                                   as Retention1Rate,
      cast(Retention1.ConditionAmount as abap.dec(13,2))                                                                      as Retention1Amount,

      cast(Retention2.ConditionRateValue as abap.dec(13,2))                                                                   as Retention2Rate,
      cast(Retention2.ConditionAmount as abap.dec(13,2))                                                                      as Retention2Amount,

      cast(Retention3.ConditionRateValue as abap.dec(13,2))                                                                   as Retention3Rate,
      cast(Retention3.ConditionAmount as abap.dec(13,2))                                                                      as Retention3Amount,

      cast(Retention4.ConditionRateValue as abap.dec(13,2))                                                                   as Retention4Rate,
      cast(Retention4.ConditionAmount as abap.dec(13,2))                                                                      as Retention4Amount,

      cast(BillingItem.GrossAmount as abap.dec(13,3))                                                                         as GrossAmount,

      BillingItem.WBSElementInternalID                                                                                        as Wbs,
      Wbs.ProjectElement                                                                                                      as WbsDescription,
      Project.Project                                                                                                         as Project,

      GLItem.AccountingDocument                                                                                               as PaymentDocument,
      GLItem.AssignmentReference                                                                                              as UTRNumber,
      GLItem.PostingDate                                                                                                      as PaymentDate
}
