(:: pragma bea:global-element-return element="ns0:ConsultaTarjetaCreditoTypeResponse" location="ConsultaTarjetaCreditoCliente.xsd" ::)

declare namespace ns0 = "ConsultaTarjetaCreditoCliente";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaTC/consultaSaldosTCHeaderOut/";

declare function xf:consultaSaldosTCHeaderOut($successIndicator as xs:string)
    as element(ns0:ConsultaTarjetaCreditoTypeResponse) {
        <ns0:ConsultaTarjetaCreditoTypeResponse>
            <ns0:RESPONSE_HEADER>
                <ns0:SUCCESS_INDICATOR>{ $successIndicator }</ns0:SUCCESS_INDICATOR>
            </ns0:RESPONSE_HEADER>
        </ns0:ConsultaTarjetaCreditoTypeResponse>
};

declare variable $successIndicator as xs:string external;

xf:consultaSaldosTCHeaderOut($successIndicator)