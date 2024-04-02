@EndUserText.label: 'Sales Data Report Projection View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_SALES_DATA_REPORT
  provider contract transactional_query
  as projection on ZI_SALES_DATA_REPORT
{
  key BillingDocument,
  key BillingDocumentItem,
      BillingDocumentDate,
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
      TotalGST,
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
      GrossAmount,
      TotalAdjustment,
      GrossReceivables,
      Wbs,
      WbsDescription
}
