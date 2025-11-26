(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma  parameter="$MODULE_CODE" type="anyType" ::)
(:: pragma  parameter="$PROCESS_CODE" type="anyType" ::)
(:: pragma  parameter="$TYPE_SEND_EMAIL" type="anyType" ::)
(:: pragma  parameter="$FROM" type="anyType" ::)
(:: pragma  parameter="$TO" type="anyType" ::)
(:: pragma bea:global-element-parameter parameter="$evaluaListasClienteRequest" element="ns2:evaluaListasClienteRequest" location="../xsd/evaluaListasClienteTypes.xsd" ::)
(:: pragma  parameter="$NOMBRELISTA" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:enviarCorreo" location="../../OperacionesCorreoElectronico/xsd/operacionesCorreoElectronicoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCorreoElectronicoTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/evaluaListasClienteTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaListasCliente/xq/evaluaListasClienteEnvioCorreo/";

declare function xf:evaluaListasClienteEnvioCorreo($requestHeader as element(ns1:RequestHeader),
    $MODULE_CODE as xs:string,
    $PROCESS_CODE as xs:string,
    $TYPE_SEND_EMAIL as xs:string,
    $FROM as xs:string,
    $TO as xs:string,
    $evaluaListasClienteRequest as element(ns2:evaluaListasClienteRequest),
    $NOMBRELISTA as xs:string,
    $LISTA as xs:string)
    as element(ns0:enviarCorreo) {
        <ns0:enviarCorreo>
            <MODULE_CODE>{ $MODULE_CODE }</MODULE_CODE>
            <PROCESS_CODE>{ $PROCESS_CODE }</PROCESS_CODE>
            <TYPE_SEND_EMAIL>{ $TYPE_SEND_EMAIL }</TYPE_SEND_EMAIL>
            <FROM>{ $FROM }</FROM>
            <TO>{ $TO }</TO>
            {
                for $TRANSACTION_ID in $evaluaListasClienteRequest/TRANSACTION_ID,
                    $TRANSACTION_DATE in $evaluaListasClienteRequest/TRANSACTION_DATE,
                    $TYPE_OF_TRANSACTION in $evaluaListasClienteRequest/TYPE_OF_TRANSACTION,
                    $NAME_TO_EVALUATE in $evaluaListasClienteRequest/NAME_TO_EVALUATE,
                    $AMOUNT in $evaluaListasClienteRequest/AMOUNT,
                    $COUNTRY in $evaluaListasClienteRequest/COUNTRY,
                    $USERNAME in upper-case($requestHeader/Authentication/UserName)
                return
                    <MESSAGE_PARAMETERS>{ concat($TRANSACTION_ID ,"~", $TRANSACTION_DATE ,"~", $TYPE_OF_TRANSACTION ,"~", $NAME_TO_EVALUATE ,"~", $AMOUNT ,"~", $COUNTRY,"~", $USERNAME,"~",$NOMBRELISTA,"~",$LISTA) }</MESSAGE_PARAMETERS>
            }
        </ns0:enviarCorreo>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $MODULE_CODE as xs:string external;
declare variable $PROCESS_CODE as xs:string external;
declare variable $TYPE_SEND_EMAIL as xs:string external;
declare variable $FROM as xs:string external;
declare variable $TO as xs:string external;
declare variable $evaluaListasClienteRequest as element(ns2:evaluaListasClienteRequest) external;
declare variable $NOMBRELISTA as xs:string external;
declare variable $LISTA as xs:string external;

xf:evaluaListasClienteEnvioCorreo($requestHeader,
    $MODULE_CODE,
    $PROCESS_CODE,
    $TYPE_SEND_EMAIL,
    $FROM,
    $TO,
    $evaluaListasClienteRequest,
    $NOMBRELISTA,
    $LISTA)
