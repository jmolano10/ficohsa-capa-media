xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/Collection/Collection.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::) external;
declare variable $CollectionResponse as element() (:: schema-element(ns2:CalculoCobranzasReferenciadasResponse) ::) external;
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

declare function local:func($GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::), 
                            $CollectionResponse as element() (:: schema-element(ns2:CalculoCobranzasReferenciadasResponse) ::), 
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
        <ns1:ContractId>{fn:data($GetCollectionRequest/ns1:ContractId)}</ns1:ContractId>
        <ns1:ContractName>{fn:data($ContractName)}</ns1:ContractName>
        <ns1:DebtorCode>{fn:data($GetCollectionRequest/ns1:DebtorCode)}</ns1:DebtorCode>
        {
          if(fn:data($GetCollectionRequest/ns1:AdditionalInfo/ns1:Data[4])!='')then(
            <ns1:DebtorName>{fn:data($GetCollectionRequest/ns1:AdditionalInfo/ns1:Data[4])}</ns1:DebtorName>
          )else()
        }
        <ns1:Bills>
        {
          let $gNOFILELATAMCALCREFDUEWSDetailType := $CollectionResponse/NOFILELATAMCALCREFDUEWSType[1]/gNOFILELATAMCALCREFDUEWSDetailType
          return
            <ns1:BillRecord>
              {
                if(fn:data($GetCollectionRequest/ns1:AdditionalInfo/ns1:Data[1])='')then(
                  <ns1:BillNumber>{fn:data($GetCollectionRequest/ns1:DebtorCode)}</ns1:BillNumber>
                )else(
                  <ns1:BillNumber>{fn:data($GetCollectionRequest/ns1:AdditionalInfo/ns1:Data[1])}</ns1:BillNumber>
                )
              }
                <ns1:BillCurrency>{fn:data($GetCollectionRequest/ns1:Currency)}</ns1:BillCurrency>
                {
                    if ($GetCollectionRequest/ns1:BillDate)
                    then <ns1:BillDate>{fn:data($GetCollectionRequest/ns1:BillDate)}</ns1:BillDate>
                    else ()
                }
                {
                    if ($GetCollectionRequest/ns1:BillDate)
                    then <ns1:DueDate>{fn:data($GetCollectionRequest/ns1:BillDate)}</ns1:DueDate>
                    else ()
                }
                {
                    if ($GetCollectionRequest/ns1:BillAmount)
                    then <ns1:BillAmount>{fn-bea:format-number(xs:double(fn:data($GetCollectionRequest/ns1:BillAmount)),"######0.00")}</ns1:BillAmount>
                    else ()
                }
                {
                    let $NETAMOUNT :=  substring(fn:string($gNOFILELATAMCALCREFDUEWSDetailType/mNOFILELATAMCALCREFDUEWSDetailType[1]/TOTALAMOUNT/text()),4)
                    let $LRAMT := fn:string($GetCollectionRequest/ns1:BillAmount/text())
                    return
                      <ns1:LateFee>{ fn-bea:fail-over(fn-bea:format-number(round-half-to-even((xs:double($NETAMOUNT) - xs:double($LRAMT)),2),"######0.00"),-1) }</ns1:LateFee>
                }
                {
                    for $montoFactura in substring(fn:string($gNOFILELATAMCALCREFDUEWSDetailType/mNOFILELATAMCALCREFDUEWSDetailType[1]/TOTALAMOUNT/text()),4)
                      let $monedaFactura := $GetCollectionRequest/ns1:Currency
                      let $monedaConsulta := data($GetCollectionRequest/ns1:Currency)
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
    </ns1:getCollectionResponse>
};

local:func($GetCollectionRequest, $CollectionResponse, $ContractName, $buyRate, $sellRate, $uuid)