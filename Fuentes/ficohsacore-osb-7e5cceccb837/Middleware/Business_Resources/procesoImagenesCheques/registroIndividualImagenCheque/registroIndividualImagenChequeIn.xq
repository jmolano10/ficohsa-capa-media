(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$registroIndividualImagenChequeRequest1" element="ns0:registroIndividualImagenChequeRequest" location="../Resources/procesoImagenesChequesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:registrarImagenesCheques" location="../Resources/XMLSchema_-753785776.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://services.com/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesoImagenesChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/procesoImagenesCheques/registroIndividualImagenCheque/registroIndividualImagenChequeIn/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

declare function xf:registroIndividualImagenChequeIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $registroIndividualImagenChequeRequest1 as element(ns0:registroIndividualImagenChequeRequest))
    as element(ns1:registrarImagenesCheques) {
        <ns1:registrarImagenesCheques>
            <registroImagenesChequesRequest>
                <referenciaTransaccion>{ data($registroIndividualImagenChequeRequest1/TRANSACTION_ID) }</referenciaTransaccion>
                <numeroCuenta>{ data($registroIndividualImagenChequeRequest1/ACCOUNT_NUMBER) }</numeroCuenta>
                <numeroCheque>{ data($registroIndividualImagenChequeRequest1/CHEQUE_NUMBER) }</numeroCheque>
                <fechaTransaccion>{ data($registroIndividualImagenChequeRequest1/TRANSACTION_DATE) }</fechaTransaccion>
                <usuario>
                    {
                        fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)),
                        data($autenticacionRequestHeader1/UserName))
                    }
				</usuario>
                <anversoCheque>{ data($registroIndividualImagenChequeRequest1/CHEQUE_IMAGE_FRONT) }</anversoCheque>
                <reversoCheque>{ data($registroIndividualImagenChequeRequest1/CHEQUE_IMAGE_BACK) }</reversoCheque>
                <formatoImagen>{ data($registroIndividualImagenChequeRequest1/FILE_EXTENSION) }</formatoImagen>
            </registroImagenesChequesRequest>
        </ns1:registrarImagenesCheques>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $registroIndividualImagenChequeRequest1 as element(ns0:registroIndividualImagenChequeRequest) external;

xf:registroIndividualImagenChequeIn($autenticacionRequestHeader1,
    $registroIndividualImagenChequeRequest1)