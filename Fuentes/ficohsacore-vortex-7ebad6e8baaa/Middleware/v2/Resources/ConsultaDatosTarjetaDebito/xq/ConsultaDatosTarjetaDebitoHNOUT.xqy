xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaDebitoResponse" location="../xsd/ConsultaDatosTarjetaDebitoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ConsultaDatosTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaDebito/ConsultaDatosTarjetaDebitoHNOUT/";
(: Se encarga de calcular el estatus de tarjeta :)
declare function calcCardStatus($estatusTarjeta as xs:string) as xs:string {
	if ($estatusTarjeta = "90") then
		"ISSUED"
	else if  ($estatusTarjeta = "93") then
		"CANCELED"
       else if  ($estatusTarjeta = "94") then
		"ACTIVE"
	else 
		"OTHERS"
};

declare function xf:ConsultaDatosTarjetaDebitoHNOUT($codigoCliente as xs:string,
    $cardName as xs:string,
    $tipoTarjeta as xs:string,
    $estatusTarjeta as xs:string,
    $cuentasPrimarias as xs:string,
    $cuentasSecundarias as xs:string,
    $codigoMoneda as xs:string)
    as element(ns0:consultaDatosTarjetaDebitoResponse) {
        <ns0:consultaDatosTarjetaDebitoResponse>
            <CUSTOMER_ID>{ data($codigoCliente) }</CUSTOMER_ID>
            <CARD_NAME>{ data($cardName) }</CARD_NAME>
            <CATEGORY_CARD>{ data($tipoTarjeta) }</CATEGORY_CARD>
            <STATUS_CARD>{ calcCardStatus($estatusTarjeta) }</STATUS_CARD>
            <ACCOUNTS>
               <MAIN_ACCOUNTS>
					{
						let $accounts := fn:tokenize($cuentasPrimarias, ";")
						let $currency := fn:tokenize($codigoMoneda, ";")
						for $x in 1 to fn:count($accounts)
						return
						if (fn:data($accounts[$x])) then
							<MAIN_ACCOUNT>
								<ACCOUNT>{ data($accounts[$x]) }</ACCOUNT>
								<ACCOUNT_CURRENCY>{ data($currency[$x]) }</ACCOUNT_CURRENCY>
							</MAIN_ACCOUNT>
						else ()
					}
					</MAIN_ACCOUNTS>
					<SECUNDARY_ACCOUNTS>
					{
						let $accounts := fn:tokenize($cuentasSecundarias, ";")
						let $currency := fn:tokenize($codigoMoneda, ";")
						for $x in 1 to fn:count($accounts)
						return
						if (fn:data($accounts[$x])) then
							<SECUNDARY_ACCOUNT>
								<ACCOUNT>{ data($accounts[$x]) }</ACCOUNT>
								<ACCOUNT_CURRENCY>{ data($currency[$x]) }</ACCOUNT_CURRENCY>
							</SECUNDARY_ACCOUNT>
						else ()
					}
					</SECUNDARY_ACCOUNTS>
            </ACCOUNTS>
        </ns0:consultaDatosTarjetaDebitoResponse>
};

declare variable $codigoCliente as xs:string external;
declare variable $cardName as xs:string external;
declare variable $tipoTarjeta as xs:string external;
declare variable $estatusTarjeta as xs:string external;
declare variable $cuentasPrimarias as xs:string external;
declare variable $cuentasSecundarias as xs:string external;
declare variable $codigoMoneda as xs:string external;

xf:ConsultaDatosTarjetaDebitoHNOUT($codigoCliente,
    $cardName,
    $tipoTarjeta,
    $estatusTarjeta,
    $cuentasPrimarias,
    $cuentasSecundarias,
    $codigoMoneda)