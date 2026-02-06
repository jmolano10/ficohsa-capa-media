xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$solicitudChequeras" element="ns2:solicitudChequeras" location="../xsd/solicitudChequerasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/solcitudChequeras/xsd/solicitudChequeras_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/solicitudChequeras";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/solicitudChequerasTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudChequeras/xq/solicitudChequeraPAIn/";

declare function xf:solicitudChequeraPAIn($uuid as xs:string,
    $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $solicitudChequeras as element(ns2:solicitudChequeras))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ACCOUNT_NUMBER>{ data($solicitudChequeras/ACCOUNT_NUMBER) }</ns0:PV_ACCOUNT_NUMBER>
            <ns0:PV_CHEQUEBOOK_TYPE>{ data($solicitudChequeras/CHEQUEBOOK_TYPE) }</ns0:PV_CHEQUEBOOK_TYPE>
            <ns0:PV_NO_OF_BOOKS>{ data($solicitudChequeras/NO_OF_BOOKS) }</ns0:PV_NO_OF_BOOKS>
            <ns0:PV_DESTINATION_BRANCH>{ data($solicitudChequeras/DESTINATION_BRANCH) }</ns0:PV_DESTINATION_BRANCH>
            <ns0:PV_AUTHORIZED_CLAIMER>{ data($solicitudChequeras/AUTHORIZED_CLAIMER) }</ns0:PV_AUTHORIZED_CLAIMER>
            <ns0:PV_AUTHORIZED_CLAIMER_ID>{ data($solicitudChequeras/AUTHORIZED_CLAIMER_ID) }</ns0:PV_AUTHORIZED_CLAIMER_ID>
            <ns0:PV_INTERFACE_REFERENCE_NO>{ data($solicitudChequeras/INTERFACE_REFERENCE_NO) }</ns0:PV_INTERFACE_REFERENCE_NO>
            {
                for $NO_OF_CHEQUES in $solicitudChequeras/NO_OF_CHEQUES
                return
                    <ns0:PV_NO_OF_CHEQUES>{ data($NO_OF_CHEQUES) }</ns0:PV_NO_OF_CHEQUES>
            }
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $solicitudChequeras as element(ns2:solicitudChequeras) external;

xf:solicitudChequeraPAIn($uuid,
    $autenticacionRequestHeader,
    $solicitudChequeras)