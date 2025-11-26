(:: pragma bea:global-element-return element="ns0:RegistrarTransaccionesTENGOEEH" location="../../../../BusinessServices/T24/svcGestionesTrxSEEHTENGO/xsd/svcGestionesTrxSEEHTENGOTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionesGenericasTengoEEH/transaccionesGenericasT24/xq/procesaTransaccionGenericaT24/";

declare function xf:procesaTransaccionGenericaT24($TIPO_TRANSACCION as xs:string,
    $CLAVE_CONVENIO as xs:string,
    $MONTO as xs:string,
    $MONEDA as xs:string,
    $CLAVE_CORRESPONSAL as xs:string,
    $ID_CLIENTE as xs:string,
    $NOMBRE_CLIENTE as xs:string,
    $PAYMENT_DETAILS as xs:string)
    as element(ns0:RegistrarTransaccionesTENGOEEH) {
        <ns0:RegistrarTransaccionesTENGOEEH>
            <FUNDSTRANSFERTENGOEEHType>
                <TRANSACTIONTYPE>{ $TIPO_TRANSACCION }</TRANSACTIONTYPE>
                <DEBITCURRENCY>{ $MONEDA }</DEBITCURRENCY>
                <DEBITAMOUNT>{ $MONTO }</DEBITAMOUNT>
                <gPAYMENTDETAILS>
                    <PAYMENTDETAILS>{ $PAYMENT_DETAILS }</PAYMENTDETAILS>
                </gPAYMENTDETAILS>
                <LRAGCLIENTID>{ $CLAVE_CONVENIO }</LRAGCLIENTID>
                <CLIENTID>{ $ID_CLIENTE }</CLIENTID>
            </FUNDSTRANSFERTENGOEEHType>
        </ns0:RegistrarTransaccionesTENGOEEH>
};

declare variable $TIPO_TRANSACCION as xs:string external;
declare variable $CLAVE_CONVENIO as xs:string external;
declare variable $MONTO as xs:string external;
declare variable $MONEDA as xs:string external;
declare variable $CLAVE_CORRESPONSAL as xs:string external;
declare variable $ID_CLIENTE as xs:string external;
declare variable $NOMBRE_CLIENTE as xs:string external;
declare variable $PAYMENT_DETAILS as xs:string external;

xf:procesaTransaccionGenericaT24($TIPO_TRANSACCION,
    $CLAVE_CONVENIO,
    $MONTO,
    $MONEDA,
    $CLAVE_CORRESPONSAL,
    $ID_CLIENTE,
    $NOMBRE_CLIENTE,
    $PAYMENT_DETAILS)
