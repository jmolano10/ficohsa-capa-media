(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaClienteRTE" element="ns1:consultaClienteRTE" location="../../xsds/ConsultaClienteRTE/ConsultaClienteRTE.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultaperfildecliente" location="../../xsds/PerfilCliente/XMLSchema_-994245660.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClienteRTETypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaClienteRTE/ConsultaClienteRTEIn/";

declare function xf:ConsultaClienteRTEIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaClienteRTE as element(ns1:consultaClienteRTE))
    as element(ns0:Consultaperfildecliente) {
        <ns0:Consultaperfildecliente>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <WSCUSTOMERFULLType>
                <enquiryInputCollection>
                    <columnName>LR.INDX.LEGALID</columnName>
                    <criteriaValue>{ data($consultaClienteRTE/CUSTOMER_LEGAL_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSCUSTOMERFULLType>
        </ns0:Consultaperfildecliente>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaClienteRTE as element(ns1:consultaClienteRTE) external;

xf:ConsultaClienteRTEIn($autenticacionRequestHeader,
    $consultaClienteRTE)