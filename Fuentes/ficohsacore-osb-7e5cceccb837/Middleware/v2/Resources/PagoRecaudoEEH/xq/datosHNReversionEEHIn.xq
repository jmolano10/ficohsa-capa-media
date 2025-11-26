(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns0:pagoRecaudo" location="../xsd/pagoRecaudoEEHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:DatosHNReversion" location="../../../BusinessServices/RecaudoEEHws/wsdl/recaudoEEHSOAP.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://schemas.servicestack.net/types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoEEH/xq/datosHNReversionEEHIn/";
declare namespace soapenv = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace con = "http://schemas.enee-pay.hn/contract";

declare function xf:datosHNReversionEEHIn (
	$pagoRecaudo as element(ns0:pagoRecaudo),
    $AGENCY as xs:string,
    $BANK as xs:string,
    $BRANCH_OFFICE as xs:string,
    $TERMINAL as xs:string,
    $USER as xs:string,
    $UUID as xs:string,
    $fechaPago as xs:string,
    $horaPago as xs:string
    ) as element(*) {
		<con:RevertirPagoRequest> 
		    <con:AgenteRecaudador> 
			    <con:CodigoAgenteRecaudador> {$AGENCY} </con:CodigoAgenteRecaudador> 
			    <con:CodigoSucursal> {$BRANCH_OFFICE} </con:CodigoSucursal> 
			    <con:Terminal> {$TERMINAL} </con:Terminal> 
			    <con:Usuario> {$USER} </con:Usuario> 
		    </con:AgenteRecaudador> 
		    <con:ClavePrimaria>{ data($pagoRecaudo/DEBTOR_CODE)}</con:ClavePrimaria> 
		    <con:FechaPago> {$fechaPago} </con:FechaPago> 
		    <con:HoraPago> {$horaPago} </con:HoraPago> 
		    <con:IdTransaccionAgenteRecaudador> {$UUID} </con:IdTransaccionAgenteRecaudador> 
		    <con:Monto> { data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) } </con:Monto> 
	    </con:RevertirPagoRequest>	  
	};

declare variable $pagoRecaudo as element(ns0:pagoRecaudo) external;
declare variable $AGENCY as xs:string external;
declare variable $BANK as xs:string external;
declare variable $BRANCH_OFFICE as xs:string external;
declare variable $TERMINAL as xs:string external;
declare variable $USER as xs:string external;
declare variable $UUID as xs:string external;
declare variable $fechaPago as xs:string external;
declare variable $horaPago as xs:string external;

xf:datosHNReversionEEHIn (
	$pagoRecaudo,
    $AGENCY,
    $BANK,
    $BRANCH_OFFICE,
    $TERMINAL,
    $USER,
    $UUID,
    $fechaPago,
    $horaPago
)