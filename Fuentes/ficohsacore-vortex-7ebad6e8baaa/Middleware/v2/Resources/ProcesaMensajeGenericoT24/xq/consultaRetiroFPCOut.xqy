xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/FPC/consultaRetiroFPC/xsd/CONSULTA_RETIRO_FPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CONSULTA_RETIRO_FPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consultaRetiroFPC/";

declare function xf:consultaRetiroFPC($outputParameters as element(ns1:OutputParameters) , $transactionId as xs:string,
    $sessionId as xs:string)
    as element(ns0:procesaMensajeGenericoT24) {
        <ns0:procesaMensajeGenericoT24>
        	<TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            <MESSAGE>{ concat($outputParameters/ns1:P_ERROR_CODE, '|', $outputParameters/ns1:P_ERROR, '|', $outputParameters/ns1:P_NUM_CUENTA, '|' , $outputParameters/ns1:P_NOMBRE_CLIENTE, '|' , $outputParameters/ns1:P_ID_CLIENTE, '|' , $outputParameters/ns1:P_F_PAGO, '|' , $outputParameters/ns1:P_MONEDA_P, '|' , $outputParameters/ns1:P_MONTO_P, '|' , $outputParameters/ns1:P_TIPO_P, '|', $outputParameters/ns1:P_CUENTA_BANCARIA) }</MESSAGE>
        </ns0:procesaMensajeGenericoT24>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;

xf:consultaRetiroFPC($outputParameters, $transactionId,
    $sessionId)