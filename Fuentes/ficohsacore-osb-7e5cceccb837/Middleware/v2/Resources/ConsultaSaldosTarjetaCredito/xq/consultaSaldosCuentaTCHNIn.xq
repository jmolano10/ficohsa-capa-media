(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/MasterData/conConsultaSaldoTCRG/xsd/conConsultaSaldosCuentaTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conConsultaSaldosCuentaTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosCuentaTCHNIn/";

declare function xf:consultaSaldosCuentaTCHNIn($pais as xs:string,
    $cuenta as xs:string,
    $org as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $pais }</ns0:Pais>
            <ns0:NumCuenta>{ $cuenta }</ns0:NumCuenta>
            <ns0:Org>{ $org }</ns0:Org>
            <ns0:CodigoError>0</ns0:CodigoError>
            <ns0:MensajeError>null</ns0:MensajeError>
        </ns0:InputParameters>
};

declare variable $pais as xs:string external;
declare variable $cuenta as xs:string external;
declare variable $org as xs:string external;

xf:consultaSaldosCuentaTCHNIn($pais,
    $cuenta,
    $org)
