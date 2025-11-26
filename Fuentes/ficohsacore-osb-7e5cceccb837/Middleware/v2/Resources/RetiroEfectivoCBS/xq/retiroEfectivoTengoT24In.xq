(:: pragma bea:global-element-parameter parameter="$HeaderCB" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$retiroEfectivoREQ" element="ns2:retiroEfectivo" location="../xsd/retiroEfectivoCBTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$ObtenerParametrosOut" element="ns3:OutputParameters" location="../../../BusinessServices/MDW/obtenerParametrizacionTengo/xsd/obtenerParametrizacionTengo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RetiroEfectivoTengo" location="../../../BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/retiroEfectivoCBTypes";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroEfectivoCBS/xq/retiroEfectivoTengoT24In/";

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

declare function xf:retiroEfectivoTengoT24In($tipoTrxT24 as xs:string,
    $cuentaCreditoT24 as xs:string,
    $HeaderCB as element(ns0:RequestHeader),
    $retiroEfectivoREQ as element(ns2:retiroEfectivo))
    as element(ns1:RetiroEfectivoTengo) {
        <ns1:RetiroEfectivoTengo>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($HeaderCB/Authentication/UserName)),
                        data($HeaderCB/Authentication/UserName))
                    }
</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($HeaderCB/Authentication/UserName)),
                        data($HeaderCB/Authentication/Password))
                    }
</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILINTSALEWSType>
                <TransactionType>{ $tipoTrxT24 }</TransactionType>
                <DebitAccount>{ data($retiroEfectivoREQ/ACCOUNT_NUMBER) }</DebitAccount>
                <DebitCurrency>{ data($retiroEfectivoREQ/CURRENCY) }</DebitCurrency>
                <DebitAmount>{ data($retiroEfectivoREQ/AMOUNT) }</DebitAmount>
                <CreditAccount>{ $cuentaCreditoT24 }</CreditAccount>
                <LRREFTENGO>{ data($retiroEfectivoREQ/TRANSACTION_ID_CB) }</LRREFTENGO>
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns1:RetiroEfectivoTengo>
};

declare variable $tipoTrxT24 as xs:string external;
declare variable $cuentaCreditoT24 as xs:string external;
declare variable $HeaderCB as element(ns0:RequestHeader) external;
declare variable $retiroEfectivoREQ as element(ns2:retiroEfectivo) external;

xf:retiroEfectivoTengoT24In($tipoTrxT24,
    $cuentaCreditoT24,
    $HeaderCB,
    $retiroEfectivoREQ)
