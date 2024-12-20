@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_SALES_DATA_A
  as select from ZI_SALES_DATA
{
  key BillingDocument,
  key BillingDocumentItem,
      BillingDocumentDate,
      @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      BillingQuantity,
      BillingQuantityUnit,
      FiscalYear,
      AccountingDocument,
      SoldToParty,
      SoldToPartyName,
      PayerParty,
      PayerPartyName,
      BillToParty,
      BillToPartyName,
      CustomerGST,
      RegionName,
      CountryName,
      ShipToParty,
      ShipToPartyName,
      TransactionCurrency,
      IncoTerms,
      CustomerPaymentTerms,
      CreatedByUser,
      PricingDate,
      OrganizationDivision,
      Product,
      ProductName,
      BillingDocumentType,
      OBD,
      OBDDate,
      SalesOrderNo,
      SalesOrderDate,
      HSNSac,
      ProfitCenter,
      SupplierGSTIN,
      PurchaseOrderByCustomer,
      CGSTRate,
      CGSTAmount,
      SGSTRate,
      SGSTAmount,
      IGSTRate,
      IGSTAmount,
      coalesce(CGSTAmount,0) + coalesce(SGSTAmount,0) + coalesce(IGSTAmount,0)                                                                                               as TotalGST,
      UnitRate,
      AdvanceAmount,
      Retention1Rate,
      Retention1Amount,
      Retention2Rate,
      Retention2Amount,
      Retention3Rate,
      Retention3Amount,
      Retention4Rate,
      Retention4Amount,
      coalesce(CGSTAmount,0) + coalesce(SGSTAmount,0) + coalesce(IGSTAmount,0) + coalesce(NetAmount, 0)                                                                      as GrossAmount,
      coalesce(AdvanceAmount,0) + coalesce(Retention1Amount,0) + coalesce(Retention2Amount,0) + coalesce(Retention3Amount,0) + coalesce(Retention4Amount,0)                  as TotalAdjustment,
    //  GrossAmount - (coalesce(AdvanceAmount,0) + coalesce(Retention1Amount,0) + coalesce(Retention2Amount,0) + coalesce(Retention3Amount,0) + coalesce(Retention4Amount,0) ) as GrossReceivables,
      
      (coalesce(CGSTAmount,0) + coalesce(SGSTAmount,0) + coalesce(IGSTAmount,0) + coalesce(NetAmount, 0)  ) - (coalesce(AdvanceAmount,0) + coalesce(Retention1Amount,0) + coalesce(Retention2Amount,0) + coalesce(Retention3Amount,0) + coalesce(Retention4Amount,0) ) as GrossReceivables,
      Wbs,
      WbsDescription,
      PaymentDocument,
      UTRNumber,
      PaymentDate
}
