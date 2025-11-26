xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/GetCoreParameters/GetCoreParameters.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getCollectionTypes";
(:: import schema at "../../../../../MWBanking/Collection/RequestorServices/XSD/getCollectionTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetAbanksCollections";
(:: import schema at "../../../../ProviderServices/XSD/GetAbanksCollections/GetAbanksCollections_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $GetCollectionRequest as element() (:: schema-element(ns1:getCollectionRequest) ::) external;
declare variable $GetAbanksCollectionsResponse as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $GetCoreParametersResponse as element() (:: schema-element(ns3:ConsultadeparametroscoreResponse) ::) external;
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
                            $GetAbanksCollectionsResponse as element() (:: schema-element(ns2:OutputParameters) ::), 
                            $GetCoreParametersResponse as element() (:: schema-element(ns3:ConsultadeparametroscoreResponse) ::), 
                            $uuid as xs:string) 
                            as element() (:: schema-element(ns1:getCollectionResponse) ::) {
    <ns1:getCollectionResponse>
        <ns1:StatusInfo>
            {
                if ($GetAbanksCollectionsResponse/ns2:PV_CODIGOMENSAJE)
                then <com:Status>{fn:data($GetAbanksCollectionsResponse/ns2:PV_CODIGOMENSAJE)}</com:Status>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns1:StatusInfo>
        <ns1:ContractId>{fn:data($GetCollectionRequest/ns1:ContractId)}</ns1:ContractId>
        {
            if ($GetAbanksCollectionsResponse/ns2:PV_DESCRIPCIONPLANILLA)
            then <ns1:ContractName>{fn:data($GetAbanksCollectionsResponse/ns2:PV_DESCRIPCIONPLANILLA)}</ns1:ContractName>
            else ()
        }
        <ns1:DebtorCode>{fn:data($GetCollectionRequest/ns1:DebtorCode)}</ns1:DebtorCode>
        {
            if ($GetAbanksCollectionsResponse/ns2:PV_NOMBREDEUDOR)
            then <ns1:DebtorName>{fn:data($GetAbanksCollectionsResponse/ns2:PV_NOMBREDEUDOR)}</ns1:DebtorName>
            else ()
        }
        <ns1:Bills>
        {
          let $NUMDOC  := ($GetAbanksCollectionsResponse/ns2:PT_NUMDOC/ns2:PT_NUMEROLOTE_ITEM)  
          let $MONEDA  := ($GetAbanksCollectionsResponse/ns2:PT_MONEDA/ns2:PT_CODIGODEUDOR_ITEM)  
          let $FECHAEMISION  := ($GetAbanksCollectionsResponse/ns2:PT_FECHAEMISION/ns2:PT_FECHAEMISION_ITEM)  
          let $FECHAVENC  := ($GetAbanksCollectionsResponse/ns2:PT_FECHAVENC/ns2:PT_FECHAEMISION_ITEM)  
          let $MONTO  := ($GetAbanksCollectionsResponse/ns2:PT_MONTO/ns2:PT_MONTO_ITEM)  
          let $MORA  := ($GetAbanksCollectionsResponse/ns2:PT_MORA/ns2:PT_MONTO_ITEM)  
          let $TOTAL  := ($GetAbanksCollectionsResponse/ns2:PT_TOTAL/ns2:PT_MONTO_ITEM)  
          let $DESCRIPCION := ($GetAbanksCollectionsResponse/ns2:PT_DESCRIPCION/ns2:PT_DESCRIPCION_ITEM)
          return
            for $i  in (1 to count($NUMDOC))  
            return
            (
               <ns1:BillRecord>
                  <ns1:BillNumber>{ data($NUMDOC[$i]) }</ns1:BillNumber>
                  <ns1:BillCurrency>{ data($MONEDA[$i]) }</ns1:BillCurrency>
                  <ns1:BillDate>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd",data($FECHAEMISION[$i])) }</ns1:BillDate>
                  <ns1:DueDate>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd",data($FECHAVENC[$i])) }</ns1:DueDate>
                  <ns1:BillAmount>{ data($MONTO[$i]) }</ns1:BillAmount>
                  <ns1:LateFee>{ data($MORA[$i]) }</ns1:LateFee>
                  {
                    let $montoFactura := data($TOTAL[$i])
                    let $monedaFactura :=  data($MONEDA[$i])
                    let $monedaConsulta :=  data($MONEDA[$i])
                    let $tasaCompra := $GetCoreParametersResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/BUYRATE
                    let $tasaVenta := $GetCoreParametersResponse/WSCOREPARAMETERSType[1]/gWSCOREPARAMETERSDetailType/mWSCOREPARAMETERSDetailType[1]/SELLRATE
                    let $montoTotalLocal := local:obtenerMontoTotalLocal(xs:string($montoFactura), $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                    let $montoTotalUSD := local:obtenerMontoTotalUSD(xs:string($montoFactura), $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                    return (
                      <ns1:TotalAmountLOC>{ data($montoTotalLocal) }</ns1:TotalAmountLOC>,
                      <ns1:TotalAmountUSD>{ data($montoTotalUSD) }</ns1:TotalAmountUSD>
                    )
                  }
              </ns1:BillRecord>             
            )
        }
        </ns1:Bills>
    </ns1:getCollectionResponse>
};

local:func($GetCollectionRequest, $GetAbanksCollectionsResponse, $GetCoreParametersResponse, $uuid)