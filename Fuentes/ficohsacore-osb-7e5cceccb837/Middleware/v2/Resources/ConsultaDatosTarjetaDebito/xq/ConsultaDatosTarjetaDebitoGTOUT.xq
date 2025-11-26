(:: pragma bea:global-element-return element="ns0:consultaDatosTarjetaDebitoResponse" location="../xsd/ConsultaDatosTarjetaDebitoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ConsultaDatosTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaDebito/xq/ConsultaDatosTarjetaDebitoGTOUT1/";
(: Se encarga de calcular el tipo de tarjeta :)
declare function calcCardType($tipoTarjeta as xs:string) as xs:string {
	if ($tipoTarjeta = "P") then
		"PRINCIPAL"
	else if  ($tipoTarjeta = "A") then
		"ADDITIONAL"
	else 
		""
};

(: Se encarga de calcular el estatus de tarjeta :)
declare function calcCardStatus($estatusTarjeta as xs:string) as xs:string {
	if ($estatusTarjeta = "H") then
		"ACTIVE"
	else if  ($estatusTarjeta = "E") then
		"EMITED"
    else if  ($estatusTarjeta = "V") then
		"EXPIRED"
	else if  ($estatusTarjeta = "C") then
		"CANCELED"
	else 
		"OTHERS"
};

(: Se encarga de calcular el estatus de tarjeta :)
declare function calcCurrency($currency as xs:string) as xs:string {
	if ($currency = "2") then
		"USD"
	else if  ($currency = "13") then
		"GTQ"
	else 
		""
};
declare function xf:ConsultaDatosTarjetaDebitoGTOUT1($codigoCliente as xs:string,
    $CardName as xs:string,
    $tipoTarjeta as xs:string,
    $estatusTarjeta as xs:string,
    $cuenta as xs:string,
    $codigoMoneda as xs:string,
    $ordenCuenta as xs:string)
    as element(ns0:consultaDatosTarjetaDebitoResponse) {
        <ns0:consultaDatosTarjetaDebitoResponse>
            <CUSTOMER_ID>{data($codigoCliente)}</CUSTOMER_ID>
            <CARD_NAME>{ data($CardName) }</CARD_NAME>
            <CATEGORY_CARD>{ calcCardType($tipoTarjeta) }</CATEGORY_CARD>
            <STATUS_CARD>{ calcCardStatus($estatusTarjeta) }</STATUS_CARD>
            <ACCOUNTS>
              					<MAIN_ACCOUNTS>
					{
						let $accounts := fn:tokenize($cuenta, ";")
						let $currency := fn:tokenize($codigoMoneda, ";")
						let $orden := fn:tokenize($ordenCuenta, ";")
						for $x in 1 to fn:count($accounts)
						return
						if (fn:data($orden[$x]) = '1') then
							<MAIN_ACCOUNT>
								<ACCOUNT>{ data($accounts[$x]) }</ACCOUNT>
								<ACCOUNT_CURRENCY>{ calcCurrency($currency[$x]) }</ACCOUNT_CURRENCY>
							</MAIN_ACCOUNT>
						else ()
					}
					</MAIN_ACCOUNTS>
					<SECUNDARY_ACCOUNTS>
					{
						let $accounts := fn:tokenize($cuenta, ";")
						let $currency := fn:tokenize($codigoMoneda, ";")
						let $orden := fn:tokenize($ordenCuenta, ";")
						for $x in 1 to fn:count($accounts)
						return
						if (fn:data($orden[$x]) = '2') then
							<SECUNDARY_ACCOUNT>
								<ACCOUNT>{ data($accounts[$x]) }</ACCOUNT>
								<ACCOUNT_CURRENCY>{ calcCurrency($currency[$x]) }</ACCOUNT_CURRENCY>
							</SECUNDARY_ACCOUNT>
						else ()
					}
					</SECUNDARY_ACCOUNTS>
            </ACCOUNTS>
        </ns0:consultaDatosTarjetaDebitoResponse>
};

declare variable $codigoCliente as xs:string external;
declare variable $CardName as xs:string external;
declare variable $tipoTarjeta as xs:string external;
declare variable $estatusTarjeta as xs:string external;
declare variable $cuenta as xs:string external;
declare variable $codigoMoneda as xs:string external;
declare variable $ordenCuenta as xs:string external;

xf:ConsultaDatosTarjetaDebitoGTOUT1($codigoCliente,
    $CardName,
    $tipoTarjeta,
    $estatusTarjeta,
    $cuenta,
    $codigoMoneda,
    $ordenCuenta)
