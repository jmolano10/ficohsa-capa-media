(:: pragma bea:global-element-return element="ns0:consultaEstadoTransferenciaACHEnviadaResponse" location="../xsd/consultaEstadoTransferenciaACHEnviadaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoTransferenciaACHEnviadaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransferenciaACHEnviada/xq/consultaEstadoTransferenciaACHEnviadaOut/";

declare function xf:consultaEstadoTransferenciaACHEnviadaOut(
    $secuenceId as xs:string,
    $debitAccount as xs:string,
    $statusError as xs:string,
    $refControlT24 as xs:string,
    $refTransT24 as xs:string,
    $errorCode as xs:string,
    $errorMns as xs:string)
    as element(ns0:consultaEstadoTransferenciaACHEnviadaResponse) {
        <ns0:consultaEstadoTransferenciaACHEnviadaResponse>
            <SEQUENCE_ID>{ $secuenceId }</SEQUENCE_ID>
            <DEBIT_ACCOUNT>{ $debitAccount }</DEBIT_ACCOUNT>
            <STATUS>{ $statusError }</STATUS>
            <REF_CONTROL_BACKEND>{ $refControlT24 }</REF_CONTROL_BACKEND>
            <REF_TRANSACTION_BACKEND>{ $refTransT24 }</REF_TRANSACTION_BACKEND>
            <ERROR_CODE>{ $errorCode }</ERROR_CODE>
            <ERROR_MESSAGE>{ $errorMns }</ERROR_MESSAGE>
        </ns0:consultaEstadoTransferenciaACHEnviadaResponse>
};

declare variable $secuenceId as xs:string external;
declare variable $debitAccount as xs:string external;
declare variable $statusError as xs:string external;
declare variable $refControlT24 as xs:string external;
declare variable $refTransT24 as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $errorMns as xs:string external;

xf:consultaEstadoTransferenciaACHEnviadaOut(
    $secuenceId,
    $debitAccount,
    $statusError,
    $refControlT24,
    $refTransT24,
    $errorCode,
    $errorMns)