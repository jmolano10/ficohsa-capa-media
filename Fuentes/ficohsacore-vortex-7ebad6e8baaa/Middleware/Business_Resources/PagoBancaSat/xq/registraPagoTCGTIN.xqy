xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoBancaSatRequest1" element="ns1:pagoBancaSatRequest" location="../xsd/pagoBancaSatTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../v2/BusinessServices/ABKGT/BancaSat/PagoISVTCDeclaraguate/xsd/PagoISV_TC_Declaraguate_sp.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoBancaSatTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/PagoISV_TC_Declaraguate";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoBancaSat/xq/registraConsumoTCGTIN/";
(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

declare function xf:registraConsumoTCGTIN($pagoBancaSatRequest1 as element(ns1:pagoBancaSatRequest),
    $Convenio as xs:string,
    $Estado as xs:string,
    $Canal as xs:string,
    $MetodoPago as xs:string,
    $TipoPago as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CONVENIO>{ $Convenio }</ns0:PV_CONVENIO>
            {
                for $BILL_NUMBER in $pagoBancaSatRequest1/BILL_INFORMATION/BILL_NUMBER
                return
                    <ns0:PV_CONTRATO>{ data($BILL_NUMBER) }</ns0:PV_CONTRATO>
            }
            {
                for $CARD_HOLDER_NAME in $pagoBancaSatRequest1/CREDIT_CARD_PAYMENT_INFO/CARD_HOLDER_NAME
                return
                    <ns0:PV_NOMBRE>{ data($CARD_HOLDER_NAME) }</ns0:PV_NOMBRE>
            }
            {
                for $BILL_NUMBER in $pagoBancaSatRequest1/BILL_INFORMATION/BILL_NUMBER
                return
                    <ns0:PV_FACTURA>{ data($BILL_NUMBER) }</ns0:PV_FACTURA>
            }
             {
                for $BILL_DATE in $pagoBancaSatRequest1/BILL_INFORMATION/DUE_DATE
                return
                    <ns0:PD_FECHA_FACTURA>{ xs:date(replace($BILL_DATE,'"', '')) }</ns0:PD_FECHA_FACTURA>
            }
            <ns0:PN_MONTO>{ data($pagoBancaSatRequest1/PAYMENT_AMOUNT) }</ns0:PN_MONTO>
            <ns0:PV_ESTADO>{ $Estado }</ns0:PV_ESTADO>
            <ns0:PV_CHANNEL>{  fn-bea:fail-over( getUsername(data($Canal)), 
									data($Canal)) }</ns0:PV_CHANNEL>
            <ns0:PN_MONEDA>{ 
           let $PAYMENT_CURRENCY := fn:string($pagoBancaSatRequest1/BILL_INFORMATION/CURRENCY/text())
            	return
            	if ($PAYMENT_CURRENCY = "GTQ") then (
            		320
            	) else if ($PAYMENT_CURRENCY = "USD") then (
            		840
            	) else (
            		0
            	) }</ns0:PN_MONEDA>
            <ns0:PV_METODO_PAGO>{ $MetodoPago }</ns0:PV_METODO_PAGO>
            <ns0:PV_TIPO_PAGO>{ $TipoPago }</ns0:PV_TIPO_PAGO>
            {
                for $CREDIT_CARD in $pagoBancaSatRequest1/CREDIT_CARD_PAYMENT_INFO/CREDIT_CARD
                return
                    <ns0:PV_NUMERO_TARJETA>{ data($CREDIT_CARD) }</ns0:PV_NUMERO_TARJETA>
            }
        </ns0:InputParameters>
};

declare variable $pagoBancaSatRequest1 as element(ns1:pagoBancaSatRequest) external;
declare variable $Convenio as xs:string external;
declare variable $Estado as xs:string external;
declare variable $Canal as xs:string external;
declare variable $MetodoPago as xs:string external;
declare variable $TipoPago as xs:string external;

xf:registraConsumoTCGTIN($pagoBancaSatRequest1,
    $Convenio,
    $Estado,
    $Canal,
    $MetodoPago,
    $TipoPago)