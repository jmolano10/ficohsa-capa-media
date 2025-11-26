xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/Collection/Collection.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $CollectionResponse as element() (:: schema-element(ns2:ConsultadedetallederecaudoResponse) ::) external;
declare variable $ContractName as xs:string external;
declare variable $buyRate as xs:string external;
declare variable $sellRate as xs:string external;
declare variable $uuid as xs:string external;

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

declare function local:func($CollectionResponse as element() (:: schema-element(ns2:ConsultadedetallederecaudoResponse) ::), 
                            $ContractName as xs:string, 
                            $buyRate as xs:string, 
                            $sellRate as xs:string, 
                            $uuid as xs:string) 
                            as element() (:: schema-element(ns1:getCollectionResponse) ::) {
    <ns1:getCollectionResponse>
        <ns1:StatusInfo>
            {
                if ($CollectionResponse/Status/successIndicator)
                then <com:Status>{fn:data($CollectionResponse/Status/successIndicator)}</com:Status>
                else ()
            }
            {
                if ($CollectionResponse/Status/transactionId)
                then <com:TransactionId>{fn:data($CollectionResponse/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns1:StatusInfo>
        {
                for $SERVICEID in $CollectionResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/SERVICEID
                return
                    <ns1:ContractId>{ data($SERVICEID) }</ns1:ContractId>
        }
        {
                for $SERVICENAME in $CollectionResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/SERVICENAME
                return
                    <ns1:ContractName>{ data($SERVICENAME) }</ns1:ContractName>
        }
        {
                for $DEBTORCODE in $CollectionResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/DEBTORCODE
                return
                    <ns1:DebtorCode>{ data($DEBTORCODE) }</ns1:DebtorCode>
        }
        {
                for $DEBTORNAME in $CollectionResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/DEBTORNAME
                return
                    <ns1:DebtorName>{ data($DEBTORNAME) }</ns1:DebtorName>
        }
        {
            let $result :=
            for $LATAMAGWSPENDINGBILLSType in $CollectionResponse/LATAMAGWSPENDINGBILLSType
            return
                <ns1:Bills>
                    {
                      for $mLATAMAGWSPENDINGBILLSDetailType in $LATAMAGWSPENDINGBILLSType/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType
                      return
                        <ns1:BillRecord>
                          {
                            for $BILLNUMBER in $mLATAMAGWSPENDINGBILLSDetailType/BILLNUMBER
                            return
                              <ns1:BillNumber>{fn:data($BILLNUMBER)}</ns1:BillNumber>
                          }
                          {
                            for $CURRENCY in $mLATAMAGWSPENDINGBILLSDetailType/CURRENCY
                            return
                              <ns1:BillCurrency>{fn:data($CURRENCY)}</ns1:BillCurrency>
                          }
                          {
                            for $BILLDATE in $mLATAMAGWSPENDINGBILLSDetailType/BILLDATE
                            return
                              <ns1:BillDate>{fn:data($BILLDATE)}</ns1:BillDate>
                          }
                          {
                            for $DUEDATE in $mLATAMAGWSPENDINGBILLSDetailType/DUEDATE
                            return
                              <ns1:DueDate>{fn:data($DUEDATE)}</ns1:DueDate>
                          }
                          {
                            for $BILLAMOUNT in $mLATAMAGWSPENDINGBILLSDetailType/BILLAMOUNT
                            return
                              <ns1:BillAmount>{fn:data($BILLAMOUNT)}</ns1:BillAmount>
                          }
                          {
                            for $LATEFEE in $mLATAMAGWSPENDINGBILLSDetailType/LATEFEE
                            return
                              <ns1:LateFee>{ data($LATEFEE) }</ns1:LateFee>
                          }
                          {
                            for $montoFactura in $mLATAMAGWSPENDINGBILLSDetailType/TOTALAMOUNT
                            let $monedaFactura := $mLATAMAGWSPENDINGBILLSDetailType/BILLCCY
                            let $monedaConsulta := $mLATAMAGWSPENDINGBILLSDetailType/BILLCCY
                            let $tasaCompra := $buyRate
                            let $tasaVenta := $sellRate
                            let $montoTotalLocal := local:obtenerMontoTotalLocal($montoFactura, $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                            let $montoTotalUSD := local:obtenerMontoTotalUSD($montoFactura, $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                            return
                            (
                              <ns1:TotalAmountLOC>{ data($montoTotalLocal) }</ns1:TotalAmountLOC>,
                              <ns1:TotalAmountUSD>{ data($montoTotalUSD) }</ns1:TotalAmountUSD>
                            )
                          }
                        </ns1:BillRecord>
                    }
              </ns1:Bills>
        return
          $result[1]
        }
        
    </ns1:getCollectionResponse>
};

local:func($CollectionResponse, $ContractName, $buyRate, $sellRate, $uuid)