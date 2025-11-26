xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/Collection/Collection.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/RecordRelationOperationColletion";
(:: import schema at "../../../../ProviderServices/XSD/RecordRelationOperationColletion/RecordRelationOperationColletion_sp.xsd" ::)

declare variable $CollectionResponse as element() (:: schema-element(ns1:ConsultadedetallederecaudoResponse) ::) external;
declare variable $estado as xs:string external;
declare variable $codigoDeudor as xs:string external;
declare variable $esMonedaLocal as xs:string external;
declare variable $nombreDeudor as xs:string external;
declare variable $buyrate as xs:string external;
declare variable $sellrate as xs:string external;

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

declare function local:func($CollectionResponse as element() (:: schema-element(ns1:ConsultadedetallederecaudoResponse) ::), 
                            $estado as xs:string, 
                            $codigoDeudor as xs:string, 
                            $esMonedaLocal as xs:string, 
                            $nombreDeudor as xs:string, 
                            $buyrate as xs:string, 
                            $sellrate as xs:string) 
                            as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {
            for $SERVICEID in $CollectionResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType[1]/SERVICEID
            return
              <ns2:CODIGO_CONTRATO>{fn:data($SERVICEID)}</ns2:CODIGO_CONTRATO>
        }
        <ns2:CODIGO_DEUDOR>{fn:data($codigoDeudor)}</ns2:CODIGO_DEUDOR>
        <ns2:CODIGO_FACTURA>
        {
            for $BILLNUMBER in $CollectionResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/BILLNUMBER
            return
              <ns2:CODIGO_FACTURA_ITEM>{fn:data($BILLNUMBER)}</ns2:CODIGO_FACTURA_ITEM>
        }
        </ns2:CODIGO_FACTURA>
        <ns2:MONEDA_FACTURA>
        {
            for $BILLCCY in $CollectionResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/BILLCCY
            return
              <ns2:CODIGO_FACTURA_ITEM>{fn:data($BILLCCY)}</ns2:CODIGO_FACTURA_ITEM>
        }
        </ns2:MONEDA_FACTURA>
        <ns2:FECHA_FACTURA>
        {
            for $BILLDATE in $CollectionResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/BILLDATE
            return
              <ns2:CODIGO_FACTURA_ITEM>{fn:data($BILLDATE)}</ns2:CODIGO_FACTURA_ITEM>
        }
        </ns2:FECHA_FACTURA>
        <ns2:FECHA_VENCIMIENTO>
        {
            for $DUEDATE in $CollectionResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/DUEDATE
            return
              <ns2:CODIGO_FACTURA_ITEM>{fn:data($DUEDATE)}</ns2:CODIGO_FACTURA_ITEM>
        }
            
        </ns2:FECHA_VENCIMIENTO>
        <ns2:MONTO_FACTURA>
        {
            for $BILLAMOUNT in $CollectionResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/BILLAMOUNT
            return
              <ns2:CODIGO_FACTURA_ITEM>{fn:data($BILLAMOUNT)}</ns2:CODIGO_FACTURA_ITEM>
        }
        </ns2:MONTO_FACTURA>
        <ns2:MORA>
        {
            for $LATEFEE in $CollectionResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/LATEFEE
            return
              <ns2:CODIGO_FACTURA_ITEM>{fn:data($LATEFEE)}</ns2:CODIGO_FACTURA_ITEM>
        }
        </ns2:MORA>
        <ns2:MONTO_TOTAL>
        {
          let $tasaCompra := $buyrate
          let $tasaVenta := $sellrate
          let $montos := $CollectionResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/TOTALAMOUNT
          let $monedasFacturas := $CollectionResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/BILLCCY
          let $monedasConsultas := $CollectionResponse/LATAMAGWSPENDINGBILLSType[1]/gLATAMAGWSPENDINGBILLSDetailType/mLATAMAGWSPENDINGBILLSDetailType/CURRENCY
          for $montoFactura at $i in $montos
            let $monedaFactura := $monedasFacturas[$i]
            let $monedaConsulta := $monedasConsultas[$i]
            let $montoTotalReg := 
            (
            	if ($esMonedaLocal = '1') then (
                  local:obtenerMontoTotalLocal($montoFactura, $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                ) else if ($esMonedaLocal = '0')then(
                  local:obtenerMontoTotalUSD($montoFactura, $monedaFactura, $monedaConsulta, $tasaCompra, $tasaVenta)
                )else()
            )
            return(
              <ns2:CODIGO_FACTURA_ITEM>{ data($montoTotalReg) }</ns2:CODIGO_FACTURA_ITEM>
            )
        }
        </ns2:MONTO_TOTAL>
        <ns2:MONEDA_SOLICITUD>
            <ns2:CODIGO_FACTURA_ITEM>
            {
              if($esMonedaLocal = '1')then(
                'HNL'
              )else if ($esMonedaLocal = '0')then(
                'USD'
              )else()
            }
            </ns2:CODIGO_FACTURA_ITEM>
        </ns2:MONEDA_SOLICITUD>
        <ns2:ESTADO>{fn:data($estado)}</ns2:ESTADO>
        <ns2:NOMBRE_DEUDOR>{fn:data($nombreDeudor)}</ns2:NOMBRE_DEUDOR>
    </ns2:InputParameters>
};

local:func($CollectionResponse, $estado, $codigoDeudor, $esMonedaLocal, $nombreDeudor, $buyrate, $sellrate)