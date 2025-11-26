(:: pragma bea:global-element-parameter parameter="$consultaEstadoChequeGerencia1" element="ns1:consultaEstadoChequeGerencia" location="../../xsds/ConsultaEstadoChequeGerencia/ConsultaEstadoChequeGerencia.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadechequedegerenciaFCY" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoChequeGerenciaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaEstadoChequeGerencia/consultaChequeGerenciaFcyIn/";

declare function xf:consultaChequeGerenciaFcyIn($username as xs:string,
    $password as xs:string,
    $consultaEstadoChequeGerencia1 as element(ns1:consultaEstadoChequeGerencia),
    $nostroAccount as xs:string)
    as element(ns0:ConsultadechequedegerenciaFCY) {
        <ns0:ConsultadechequedegerenciaFCY>
            <WebRequestCommon>
                <userName>{ $username }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <FICOHNFCYDRAFTDETAILSWSType>
                <enquiryInputCollection>
                    <columnName>CHEQUE.NUMBER</columnName>
                    <criteriaValue>{ data($consultaEstadoChequeGerencia1/CHEQUE_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
	            <enquiryInputCollection>
	               <columnName>CURRENCY</columnName>
	               <criteriaValue>{ fn:upper-case(data($consultaEstadoChequeGerencia1/CURRENCY)) }</criteriaValue>
	               <operand>EQ</operand>
	            </enquiryInputCollection>
	            <enquiryInputCollection>
	               <columnName>NOSTRO.ACCOUNT</columnName>
	               <criteriaValue>{ $nostroAccount }</criteriaValue>
	               <operand>EQ</operand>
	            </enquiryInputCollection>                
            </FICOHNFCYDRAFTDETAILSWSType>
        </ns0:ConsultadechequedegerenciaFCY>
};

declare variable $consultaEstadoChequeGerencia1 as element(ns1:consultaEstadoChequeGerencia) external;
declare variable $nostroAccount as xs:string external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;

xf:consultaChequeGerenciaFcyIn($username,
    $password,
    $consultaEstadoChequeGerencia1,$nostroAccount)