(:: pragma bea:global-element-parameter parameter="$consultaEstadoChequeGerencia1" element="ns1:consultaEstadoChequeGerencia" location="../../xsds/ConsultaEstadoChequeGerencia/ConsultaEstadoChequeGerencia.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadechequedegerencia" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoChequeGerenciaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaEstadoChequeGerencia/consultaChequeGerenciaLcyIn/";

declare function xf:consultaChequeGerenciaLcyIn($username as xs:string,
    $password as xs:string,
    $consultaEstadoChequeGerencia1 as element(ns1:consultaEstadoChequeGerencia))
    as element(ns0:Consultadechequedegerencia) {
        <ns0:Consultadechequedegerencia>
            <WebRequestCommon>
                <userName>{ $username }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <WSFICOECASHIERCHEQUEDETAILSType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($consultaEstadoChequeGerencia1/CHEQUE_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOECASHIERCHEQUEDETAILSType>
        </ns0:Consultadechequedegerencia>
};

declare variable $consultaEstadoChequeGerencia1 as element(ns1:consultaEstadoChequeGerencia) external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;

xf:consultaChequeGerenciaLcyIn($username,
    $password,
    $consultaEstadoChequeGerencia1)