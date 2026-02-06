xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TercerosPA/armarPagoRecaudo/xsd/armarPagoRecaudo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/armarPagoRecaudo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoPA/xq/armarPagoRecaudoIn/";

declare function xf:convertirTipoProducto(
	$tipoProducto as xs:string)	as xs:string	{
	if($tipoProducto = 'BCA') then(
		'1'
	)else if($tipoProducto = 'BCC')then(
		'2'
	)else if($tipoProducto = 'BTC')then(
		'3'
	)else()
};

declare function xf:armarPagoRecaudoIn($pagoRecaudo as element(ns1:pagoRecaudo),
    $secuenciaPago as xs:string,
    $sesion as xs:string,
    $usuario as xs:string,
    $tipoProducto as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDCONVENIO>{ data($pagoRecaudo/CONTRACT_ID) }</ns0:PV_IDCONVENIO>
            <ns0:PV_CODIGODEUDOR>{ data($pagoRecaudo/DEBTOR_CODE) }</ns0:PV_CODIGODEUDOR>
            <ns0:PV_MEDIODEPAGO>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_METHOD) }</ns0:PV_MEDIODEPAGO>
            <ns0:PV_MONEDA>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns0:PV_MONEDA>
            <ns0:PV_MONTO>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</ns0:PV_MONTO>
            {
                for $DEBIT_ACCOUNT in $pagoRecaudo/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                return
                    <ns0:PV_CUENTADEBITO>{ data($DEBIT_ACCOUNT) }</ns0:PV_CUENTADEBITO>
            }
            {
                for $CREDIT_CARD_NUMBER in $pagoRecaudo/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                return
                    <ns0:PV_TARJETACREDITO>{ data($CREDIT_CARD_NUMBER) }</ns0:PV_TARJETACREDITO>
            }
            {
                for $EXPIRATION_DATE in $pagoRecaudo/PAYMENT_INFORMATION/EXPIRATION_DATE
                return
                    <ns0:PV_FECHAEXPTCR>{ data($EXPIRATION_DATE) }</ns0:PV_FECHAEXPTCR>
            }
            <ns0:PV_SECUENCIAPAGO>{ $secuenciaPago }</ns0:PV_SECUENCIAPAGO>
            {
                for $ADDITIONAL_INFO in $pagoRecaudo/ADDITIONAL_INFO
                return
                   <ns0:PT_INFODATA>
                   {
                    for $data at $i in $ADDITIONAL_INFO/DATA
                    return
                    (
                           <ns0:PT_INFODATA_ITEM>
                                  <ns0:NAME>{concat('DATA_',$i)}</ns0:NAME>
                                  <ns0:VALUE>{data($data)}</ns0:VALUE>
                           </ns0:PT_INFODATA_ITEM>
                    )
                    }
                   </ns0:PT_INFODATA>
            }
            <ns0:PV_SESION>{ $sesion }</ns0:PV_SESION>
            <ns0:PV_USUARIOCANAL>{ $usuario }</ns0:PV_USUARIOCANAL>
            <ns0:PV_TIPOCUENTA>{xf:convertirTipoProducto($tipoProducto)}</ns0:PV_TIPOCUENTA>
        </ns0:InputParameters>
};

declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $secuenciaPago as xs:string external;
declare variable $sesion as xs:string external;
declare variable $usuario as xs:string external;
declare variable $tipoProducto as xs:string external;

xf:armarPagoRecaudoIn($pagoRecaudo,
    $secuenciaPago,
    $sesion,
    $usuario,
    $tipoProducto)