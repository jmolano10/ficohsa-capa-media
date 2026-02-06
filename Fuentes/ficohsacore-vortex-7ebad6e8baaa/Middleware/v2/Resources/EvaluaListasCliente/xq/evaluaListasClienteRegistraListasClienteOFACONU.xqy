xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$evaluaListasClienteRequest" element="ns2:evaluaListasClienteRequest" location="../xsd/evaluaListasClienteTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns3:OutputParameters" location="../../../BusinessServices/SecValidaRemesaenListas/xsd/validaRemesasenListas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ListasOFACONU" location="../../../BusinessServices/EvaluaListasCliente/xsd/XMLSchema_-105785688.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/evaluaListasClienteTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaListasCliente/xq/prueba2/";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaRemesasenListas";

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

declare function xf:evaluaListasClienteRegistraListasClienteOFACONU($requestHeader as element(ns0:RequestHeader),
    $evaluaListasClienteRequest as element(ns2:evaluaListasClienteRequest),
    $acceptancestatus as xs:string,
    $outputParameters as element(ns3:OutputParameters))
    as element(ns1:ListasOFACONU) {
        <ns1:ListasOFACONU>
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
			<FICOHNREVISIONOFACTXNINPUTWSType id = "{ data($evaluaListasClienteRequest/TRANSACTION_ID) }">
                {
                    for $TRANSACTION_DATE in $evaluaListasClienteRequest/TRANSACTION_DATE
                    return
                        <DateAlert>{ data($TRANSACTION_DATE) }</DateAlert>
                }
                {
                    for $TYPE_OF_TRANSACTION in $evaluaListasClienteRequest/TYPE_OF_TRANSACTION
                    return
                        <TransactionType>{ data($TYPE_OF_TRANSACTION) }</TransactionType>
                }
                {
                    for $NAME_TO_EVALUATE in $evaluaListasClienteRequest/NAME_TO_EVALUATE
                    return
                        <Name>{ data($NAME_TO_EVALUATE) }</Name>
                }
                {
                    for $AMOUNT in $evaluaListasClienteRequest/AMOUNT
                    return
                        <Monto>{ data($AMOUNT) }</Monto>
                }
                <gNAMECONS>
                    {
                        for $PV_LISTAS_ITEM in $outputParameters/ns3:TR_LISTAS/ns3:TR_LISTAS_ITEM
                        return
                            <mNAMECONS>
                                {
                                    for $NOMBRE_ORDENANTE in $PV_LISTAS_ITEM/ns3:NOMBRE_ORDENANTE
                                    return
                                        <Coincidences>{ data($NOMBRE_ORDENANTE) }</Coincidences>
                                }
                                {
                                    for $ID_LISTA in $PV_LISTAS_ITEM/ns3:ID_LISTA
                                    return
                                        <NameList>{ data($ID_LISTA) }</NameList>
                                }
                            </mNAMECONS>
                    }
                </gNAMECONS>
                <Acceptancestatus>{ $acceptancestatus }</Acceptancestatus>
                {
                    for $COUNTRY in $evaluaListasClienteRequest/COUNTRY
                    return
                        <Country>{ data($COUNTRY) }</Country>
                }
                {
                    for $CANAL in $evaluaListasClienteRequest/CANAL
                    return
                        <Channel>{ fn:substring(data($CANAL), 1, 15) }</Channel>
                }
            </FICOHNREVISIONOFACTXNINPUTWSType>            
        </ns1:ListasOFACONU>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $evaluaListasClienteRequest as element(ns2:evaluaListasClienteRequest) external;
declare variable $outputParameters as element(ns3:OutputParameters) external;
declare variable $acceptancestatus as xs:string external;

xf:evaluaListasClienteRegistraListasClienteOFACONU($requestHeader,
    $evaluaListasClienteRequest,
    $acceptancestatus,
    $outputParameters)