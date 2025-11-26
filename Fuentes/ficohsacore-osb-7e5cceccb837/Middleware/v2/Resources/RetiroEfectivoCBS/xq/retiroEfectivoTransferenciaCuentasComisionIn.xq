(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$retiroEfectivo" element="ns2:retiroEfectivo" location="../xsd/retiroEfectivoCBTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns4:OutputParameters" location="../../../BusinessServices/MDW/consultarCorresponsalB/xsd/consultarCorresponsalB_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns3:OutputParameters" location="../../../BusinessServices/MDW/consultaComisionesCB/xsd/consultaComisionesCB_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Transfmodelbankentrecuentas" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/retiroEfectivoCBTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns4 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarCorresponsalB";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaComisionesCB";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroEfectivoCBS/xq/retiroEfectivoTransferenciaCuentasComisionIn/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
        return
            $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
        return
            $data/con:password/text()
 };

declare function xf:retiroEfectivoTransferenciaCuentasComisionIn($requestHeader as element(ns0:RequestHeader),
    $retiroEfectivo as element(ns2:retiroEfectivo),
    $tipoTransaccionComision as xs:string,
    $cuentacomision as xs:string,
    $originalTransaction as xs:string,
    $outputParameters1 as element(ns3:OutputParameters))
    as element(ns1:Transfmodelbankentrecuentas) {
        <ns1:Transfmodelbankentrecuentas>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    }
</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILINTSALEWSType>
                <TRANSACTIONTYPE>{ $tipoTransaccionComision }</TRANSACTIONTYPE>
                <DEBITACCTNO>{ data($retiroEfectivo/ACCOUNT_NUMBER) }</DEBITACCTNO>
                <DEBITCURRENCY>{ data($retiroEfectivo/CURRENCY) }</DEBITCURRENCY>
                <DEBITAMOUNT>{ data($outputParameters1/ns3:PV_MONTO_COMISION) }</DEBITAMOUNT>
                <CREDITACCTNO>{ $cuentacomision }</CREDITACCTNO>
                <gPAYMENTDETAILS>
                    <PAYMENTDETAILS>{ concat("Comision Retiro TENGO ", $originalTransaction) }</PAYMENTDETAILS>
                </gPAYMENTDETAILS>
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns1:Transfmodelbankentrecuentas>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $retiroEfectivo as element(ns2:retiroEfectivo) external;
declare variable $tipoTransaccionComision as xs:string external;
declare variable $cuentacomision as xs:string external;
declare variable $originalTransaction as xs:string external;
declare variable $outputParameters1 as element(ns3:OutputParameters) external;

xf:retiroEfectivoTransferenciaCuentasComisionIn($requestHeader,
    $retiroEfectivo,
    $tipoTransaccionComision,
    $cuentacomision,
    $originalTransaction,
    $outputParameters1)