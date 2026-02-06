xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$solicitaFinanciamientoTC" element="ns1:solicitaFinanciamientoTC" location="../../SolicitudFinanciamientoTC/xsd/solicitudFinanciamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:CrearExtra" location="../../../BusinessServices/External/SalesforceRGNIngresaGestionExtra/wsdl/SalesforceRGNIngresaGestionExtra.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://soap.sforce.com/schemas/class/WS_IngresaGestionExtra";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudFinanciamientoTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitaFinanciamientoTC/xq/ingresaGestionExtraHNIn/";

declare function xf:ingresaGestionExtraIn($tasaInteres as xs:string,
    $tipoDesembolso as xs:string,
    $tasaDesembolso as xs:string,
    $productoCuotificar as xs:string,
    $solicitaFinanciamientoTC as element(ns1:solicitaFinanciamientoTC),
    $userchannel as xs:string)
    as element(ns2:CrearExtra) {
        <ns2:CrearExtra>
            <ns2:Cliente>{ data($solicitaFinanciamientoTC/CUSTOMER_ID) }</ns2:Cliente>
            <ns2:Plazo>{ xs:integer(data($solicitaFinanciamientoTC/NUMBER_OF_PAYMENTS)) }</ns2:Plazo>
            <ns2:Monto>{ xs:decimal(data($solicitaFinanciamientoTC/TOTAL_AMOUNT)) }</ns2:Monto>
            <ns2:TasaInteres>{ xs:decimal(data($tasaInteres)) }</ns2:TasaInteres>
            <ns2:Moneda>{ data($solicitaFinanciamientoTC/CURRENCY) }</ns2:Moneda>
            <ns2:numTarjeta>{data($solicitaFinanciamientoTC/CARD_NUMBER) }</ns2:numTarjeta>
            <ns2:TipoDesembolso>{data( $tipoDesembolso) }</ns2:TipoDesembolso>
            {
            	for $CREDIT_ACCOUNT in $solicitaFinanciamientoTC/DISBURSEMENT_INFO/KV_PAIRS/PAIR[KEY='CREDIT_ACCOUNT']/VALUE
            	return
            		<ns2:CuentaCredito>{ data($CREDIT_ACCOUNT) }</ns2:CuentaCredito>
            }
            {
            	for $ADDRESS in $solicitaFinanciamientoTC/DISBURSEMENT_INFO/KV_PAIRS/PAIR[KEY='ADDRESS']/VALUE
            	return
            		<ns2:Direccion>{ data($ADDRESS) }</ns2:Direccion>
            }
            <ns2:CorreoElectronico>{ data($solicitaFinanciamientoTC/EMAIL_ADDRESS) }</ns2:CorreoElectronico>
            <ns2:ComisionDesembolso>{ xs:decimal(data($tasaDesembolso)) }</ns2:ComisionDesembolso>
			<ns2:ProductoCuotificar>{ $productoCuotificar }</ns2:ProductoCuotificar>
            <ns2:Pais>Honduras</ns2:Pais>
            <ns2:Canal>{data($userchannel)}</ns2:Canal>
        </ns2:CrearExtra>
};

declare variable $tasaInteres as xs:string external;
declare variable $tasaDesembolso as xs:string external;
declare variable $tipoDesembolso as xs:string external;
declare variable $productoCuotificar as xs:string external;
declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $solicitaFinanciamientoTC as element(ns1:solicitaFinanciamientoTC) external;
declare variable $userchannel as xs:string external;

xf:ingresaGestionExtraIn(
    $tasaInteres,
    $tipoDesembolso,
    $tasaDesembolso,   
    $productoCuotificar,
    $solicitaFinanciamientoTC,
    $userchannel)