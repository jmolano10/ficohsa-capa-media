(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$registroMultipleImagenesChequesRequest1" element="ns0:registroMultipleImagenesChequesRequest" location="../Resources/procesoImagenesChequesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registrarImagenesCheques" location="../Resources/XMLSchema_-753785776.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://services.com/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesoImagenesChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/procesoImagenesCheques/registroMultipleImagenesCheques/registroMultipleImagenesChequesIn/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

declare function xf:registroMultipleImagenesCheques($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $registroMultipleImagenesChequesRequest1 as element(ns0:registroMultipleImagenesChequesRequest))
    as element(ns1:registrarImagenesCheques) {
        <ns1:registrarImagenesCheques>
            {
                for $registroMultipleImagenesChequesRequestType in $registroMultipleImagenesChequesRequest1/ns0:registroMultipleImagenesChequesRequestType
                return
                    <registroImagenesChequesRequest>
                        {
                            for $TRANSACTION_ID in $registroMultipleImagenesChequesRequestType/TRANSACTION_ID
                            return
                                <referenciaTransaccion>{ data($TRANSACTION_ID) }</referenciaTransaccion>
                        }
                        {
                            for $ACCOUNT_NUMBER in $registroMultipleImagenesChequesRequestType/ACCOUNT_NUMBER
                            return
                                <numeroCuenta>{ data($ACCOUNT_NUMBER) }</numeroCuenta>
                        }
                        {
                            for $CHEQUE_NUMBER in $registroMultipleImagenesChequesRequestType/CHEQUE_NUMBER
                            return
                                <numeroCheque>{ data($CHEQUE_NUMBER) }</numeroCheque>
                        }
                        {
                            for $TRANSACTION_DATE in $registroMultipleImagenesChequesRequestType/TRANSACTION_DATE
                            return
                                <fechaTransaccion>{ data($TRANSACTION_DATE) }</fechaTransaccion>
                        }
                        <usuario>
	                        {
		                        fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)),
		                        data($autenticacionRequestHeader1/UserName))
		                    }
                        </usuario>
                        {
                            for $CHEQUE_IMAGE_FRONT in $registroMultipleImagenesChequesRequestType/CHEQUE_IMAGE_FRONT
                            return
                                <anversoCheque>{ data($CHEQUE_IMAGE_FRONT) }</anversoCheque>
                        }
                        {
                            for $CHEQUE_IMAGE_BACK in $registroMultipleImagenesChequesRequestType/CHEQUE_IMAGE_BACK
                            return
                                <reversoCheque>{ data($CHEQUE_IMAGE_BACK) }</reversoCheque>
                        }
                        {
                            for $FILE_EXTENSION in $registroMultipleImagenesChequesRequestType/FILE_EXTENSION
                            return
                                <formatoImagen>{ data($FILE_EXTENSION) }</formatoImagen>
                        }
                    </registroImagenesChequesRequest>
            }
        </ns1:registrarImagenesCheques>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $registroMultipleImagenesChequesRequest1 as element(ns0:registroMultipleImagenesChequesRequest) external;

xf:registroMultipleImagenesCheques($autenticacionRequestHeader1,
    $registroMultipleImagenesChequesRequest1)