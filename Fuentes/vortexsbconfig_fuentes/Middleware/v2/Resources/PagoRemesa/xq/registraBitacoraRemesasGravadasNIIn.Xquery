<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRemesas" element="ns3:pagoRemesas" location="../xsd/pagoRemesas.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$obtenerRemesadora" element="ns4:OutputParameters" location="../../../BusinessServices/MDW/obtenerRemesadoraNI/xsd/ObtenerRemesadora_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRelConPago" element="ns0:OutputParameters" location="../../../BusinessServices/consultaRelConPagoNI/xsd/consultaRelConPago_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$payCashPickUpOrderResponse" element="ns1:payCashPickUpOrderResponse" location="../../../BusinessServices/Remesas/RIANI/payCashPickUpOrder/wsdl/payCashPickUpOrder.wsdl" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/registrarBitacoraRemesasGravadasNI/xsd/registrarBitacoraRemesasGravadas_db_sp.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarBitacoraRemesasGravadas_db";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/riaMoneyTransferTypes";
declare namespace ns4 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerRemesadora";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRelConPago";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/registraBitacoraRemesasGravadasNIIn/";

declare function xf:registraBitacoraRemesasGravadasNIIn($pagoRemesas as element(ns3:pagoRemesas),
    $obtenerRemesadora as element(ns4:OutputParameters),
    $consultaRelConPago as element(ns0:OutputParameters),
    $payCashPickUpOrderResponse as element(ns1:payCashPickUpOrderResponse),
    $errorMessage as xs:string,
    $status as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
	         <ns2:PV_CLAVEREMESA>{fn:data($pagoRemesas/REMITTANCE_ID)}</ns2:PV_CLAVEREMESA>
	        {
	            if ($obtenerRemesadora/ns4:PV_ID_CONVENIO)
	            then <ns2:PV_IDREMESADORA>{fn:data($obtenerRemesadora/ns4:PV_ID_CONVENIO)}</ns2:PV_IDREMESADORA>
	            else ()
	        }
	        {
	            if ($pagoRemesas/BENEFICIARY_INFO/NAME)
	            then <ns2:PV_NOMBREBENEFICIARIO>{fn:data($pagoRemesas/BENEFICIARY_INFO/NAME)}</ns2:PV_NOMBREBENEFICIARIO>
	            else ()
	        }
	        <ns2:PV_IDBENEFICIARIO>{fn:data($pagoRemesas/BENEFICIARY_INFO/ID)}</ns2:PV_IDBENEFICIARIO>
	        {
	            if ($consultaRelConPago/ns0:PV_REMITENTE)
	            then <ns2:PV_NOMBREREMITENTE>{fn:data($consultaRelConPago/ns0:PV_REMITENTE)}</ns2:PV_NOMBREREMITENTE>
	            else ()
	        }
	        {
	            if ($consultaRelConPago/ns0:PV_MONEDA)
	            then <ns2:PV_MONEDA>{fn:data($consultaRelConPago/ns0:PV_MONEDA)}</ns2:PV_MONEDA>
	            else ()
	        }
	        {
	            if ($consultaRelConPago/ns0:PN_MONTO)
	            then <ns2:PN_MONTO>{fn:data($consultaRelConPago/ns0:PN_MONTO)}</ns2:PN_MONTO>
	            else ()
	        }
	        {
	            if ($consultaRelConPago/ns0:PN_TASACAMBIO)
	            then <ns2:PN_TASA>{fn:data($consultaRelConPago/ns0:PN_TASACAMBIO)}</ns2:PN_TASA>
	            else ()
	        }
	        {
	            if ($consultaRelConPago/ns0:PN_MONTOLOCAL)
	            then <ns2:PN_MONTOEXTRANJERO>{fn:data($consultaRelConPago/ns0:PN_MONTOLOCAL)}</ns2:PN_MONTOEXTRANJERO>
	            else ()
	        }
	        <ns2:PV_ESTADO>{fn:data($status)}</ns2:PV_ESTADO>
	        <ns2:PV_FORMAPAGO>VEN</ns2:PV_FORMAPAGO>
	        {
	            if ($pagoRemesas/ns1:CREDIT_ACCOUNT)
	            then <ns2:PV_NUMEROCUENTA>{fn:data($pagoRemesas/CREDIT_ACCOUNT)}</ns2:PV_NUMEROCUENTA>
	            else ()
	        }
	        {
	            if ($pagoRemesas/ns1:BRANCHCODE)
	            then <ns2:PV_AGENCIA>{fn:data($pagoRemesas/BRANCHCODE)}</ns2:PV_AGENCIA>
	            else ()
	        }
	        <ns2:PD_FECHAPAGO>{ fn:string(fn:adjust-date-to-timezone(current-date(), ())) }</ns2:PD_FECHAPAGO>
	        <ns2:PV_IDTRANSACCION>{ data($payCashPickUpOrderResponse/ns1:Response/ns1:TransRefID) }</ns2:PV_IDTRANSACCION>
            <ns2:PV_IDORDEN>{ data($payCashPickUpOrderResponse/ns1:Response/ns1:OrderNo) }</ns2:PV_IDORDEN>
	        <ns2:PV_MENSAJEERROR>{fn:data($errorMessage)}</ns2:PV_MENSAJEERROR>
        </ns2:InputParameters>
};

declare variable $pagoRemesas as element(ns3:pagoRemesas) external;
declare variable $obtenerRemesadora as element(ns4:OutputParameters) external;
declare variable $consultaRelConPago as element(ns0:OutputParameters) external;
declare variable $payCashPickUpOrderResponse as element(ns1:payCashPickUpOrderResponse) external;
declare variable $errorMessage as xs:string external;
declare variable $status as xs:string external;

xf:registraBitacoraRemesasGravadasNIIn($pagoRemesas,
    $obtenerRemesadora,
    $consultaRelConPago,
    $payCashPickUpOrderResponse,
    $errorMessage,
    $status)]]></con:xquery>
    <con:dependency location="../xsd/pagoRemesas.xsd">
        <con:schema ref="Middleware/v2/Resources/PagoRemesa/xsd/pagoRemesas"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MDW/obtenerRemesadoraNI/xsd/ObtenerRemesadora_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MDW/obtenerRemesadoraNI/xsd/ObtenerRemesadora_sp"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/consultaRelConPagoNI/xsd/consultaRelConPago_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/consultaRelConPagoNI/xsd/consultaRelConPago_sp"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/Remesas/RIANI/payCashPickUpOrder/wsdl/payCashPickUpOrder.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/Remesas/RIANI/payCashPickUpOrder/wsdl/payCashPickUpOrder"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/registrarBitacoraRemesasGravadasNI/xsd/registrarBitacoraRemesasGravadas_db_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/registrarBitacoraRemesasGravadasNI/xsd/registrarBitacoraRemesasGravadas_db_sp"/>
    </con:dependency>
</con:xqueryEntry>