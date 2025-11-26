xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/Collection/Collection.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $buyRate as xs:string external;
declare variable $sellRate as xs:string external;
declare variable $Currency as xs:string external;
declare variable $ResponseCollectionT24 as element() (:: schema-element(ns1:ConsultadedetallederecaudoResponse) ::) external;

(: Se encarga de calcular el monto total en moneda local. Se asume que las monedas solo pueden ser en moneda local (monedaPais) y en USD :)
declare function local:obtenerMontoTotalLocal($montoFactura as xs:string, 
	$monedaFactura as xs:string, $monedaConsulta as xs:string,
	$tasaCompra as xs:string, $tasaVenta as xs:string) as xs:string {
	let $monedaPais := 'HNL'
	let $montoTotal := (
		if ($monedaConsulta = $monedaPais) then (
			number($montoFactura)
		) else if ($monedaFactura = $monedaPais) then (
			number($montoFactura) * number($tasaCompra)
		) else (
			number($montoFactura) * number($tasaVenta)
		)
	)
	return
		fn-bea:fail-over(
			fn-bea:format-number(
				round-half-to-even($montoTotal, 2), "######0.00"), '0.00') 
};

(: Se encarga de calcular el monto total en dólares. Se asume que las monedas solo pueden ser en moneda local (monedaPais) y en USD :)
declare function local:obtenerMontoTotalUSD($montoFactura as xs:string, 
	$monedaFactura as xs:string, $monedaConsulta as xs:string,
	$tasaCompra as xs:string, $tasaVenta as xs:string) as xs:string {
	let $monedaPais := 'HNL'
	let $montoTotal := (
		if ($monedaConsulta = 'USD') then (
			number($montoFactura)
		) else if ($monedaFactura = $monedaPais) then (
			number($montoFactura) div number($tasaCompra)
		) else (
			number($montoFactura) div number($tasaVenta)
		)
	)
	return
		fn-bea:fail-over(
			fn-bea:format-number(
				round-half-to-even($montoTotal, 2), "######0.00"), '0.00') 
};

declare function local:func($uuid as xs:string, $buyRate as xs:string, $sellRate as xs:string,$Currency as xs:string, $ResponseCollectionT24 as element() (:: schema-element(ns1:ConsultadedetallederecaudoResponse) ::)) as element() (:: schema-element(ns2:getCollectionResponse) ::) {
    <ns2:getCollectionResponse>
        <ns2:StatusInfo>
            {
                if ($ResponseCollectionT24/Status/successIndicator)
                then <com:Status>{fn:data($ResponseCollectionT24/Status/successIndicator)}</com:Status>
                else ()
            }
            {
                if ($ResponseCollectionT24/Status/transactionId)
                then <com:TransactionId>{fn:data($ResponseCollectionT24/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        {
            for $SERVICEID in $ResponseCollectionT24/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/SERVICEID
            return
              <ns2:ContractId>{fn:data($SERVICEID)}</ns2:ContractId>
        }
        {
            for $SERVICENAME in $ResponseCollectionT24/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/SERVICENAME
            return
              <ns2:ContractName>{fn:data($SERVICENAME)}</ns2:ContractName>
        }
        {
            for $DEBTORCODE in $ResponseCollectionT24/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/DEBTORCODE
            return 
              <ns2:DebtorCode>{fn:data($DEBTORCODE)}</ns2:DebtorCode>
        }
        {
            for $DEBTORNAME in $ResponseCollectionT24/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/DEBTORNAME
            return
              <ns2:DebtorName>{fn:data($DEBTORNAME)}</ns2:DebtorName>
        }
        <ns2:BillDetail></ns2:BillDetail>
        {
          let $result :=
              for $LATAMAGWSPENDINGBILLSType in $ResponseCollectionT24/LATAMAGWSPENDINGBILLSType
              return
                <ns2:Bills>
                  {
                    for $mLATAMAGWSPENDINGBILLSDetailType in $LATAMAGWSPENDINGBILLSType/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType
                    return
                      <ns2:BillRecord>
                        {
                            for $BILLNUMBER in $mLATAMAGWSPENDINGBILLSDetailType/BILLNUMBER
                            return
                              <ns2:BillNumber>{fn:data($BILLNUMBER)}</ns2:BillNumber>
                        }
                        {
                            for $CURRENCY in $mLATAMAGWSPENDINGBILLSDetailType/CURRENCY
                            return
                              <ns2:BillCurrency>{fn:data($CURRENCY)}</ns2:BillCurrency>
                        }
                        {
                            for $BILLDATE in $mLATAMAGWSPENDINGBILLSDetailType/BILLDATE
                            return
                              <ns2:BillDate>{fn:data($BILLDATE)}</ns2:BillDate>
                        }
                        {
                            for $DUEDATE in $mLATAMAGWSPENDINGBILLSDetailType/DUEDATE
                            return
                              <ns2:DueDate>{fn:data($DUEDATE)}</ns2:DueDate>
                        }
                        {
                            for $BILLAMOUNT in $mLATAMAGWSPENDINGBILLSDetailType/BILLAMOUNT
                            return
                              <ns2:BillAmount>{fn:data($BILLAMOUNT)}</ns2:BillAmount>
                        }
                        {
                            for $LATEFEE in $mLATAMAGWSPENDINGBILLSDetailType/LATEFEE
                            return
                              <ns2:LateFee>{fn:data($LATEFEE)}</ns2:LateFee>
                        }
                        {
                            for $montoFactura in $mLATAMAGWSPENDINGBILLSDetailType/TOTALAMOUNT
                              let $monedaFactura := $mLATAMAGWSPENDINGBILLSDetailType/BILLCCY
                              let $monedaConsulta := $Currency
                              let $tasaCompra := $buyRate
                              let $tasaVenta := $sellRate
                              let $montoTotalLocal := local:obtenerMontoTotalLocal($montoFactura, $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                              let $montoTotalUSD := local:obtenerMontoTotalUSD($montoFactura, $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                            return (
                              <ns2:TotalAmountLOC>{fn:data($montoTotalLocal)}</ns2:TotalAmountLOC>,
                              <ns2:TotalAmountUSD>{fn:data($montoTotalUSD)}</ns2:TotalAmountUSD>
                            )
                        }
                        {
                            for $DESCRIPTION in $mLATAMAGWSPENDINGBILLSDetailType/DESCRIPTION
                            return
                              <ns2:BillDescription>{ data($DESCRIPTION) }</ns2:BillDescription>
                                        }
                      </ns2:BillRecord>
                   }
                  </ns2:Bills>
          return
            $result[1]
        }
    </ns2:getCollectionResponse>
};

local:func($uuid, $buyRate, $sellRate, $Currency, $ResponseCollectionT24)