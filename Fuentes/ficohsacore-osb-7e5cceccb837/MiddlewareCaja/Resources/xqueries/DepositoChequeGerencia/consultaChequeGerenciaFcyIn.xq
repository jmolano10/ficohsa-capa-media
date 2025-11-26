(:: pragma bea:global-element-parameter parameter="$depositoChequeGerencia1" element="ns1:depositoChequeGerencia" location="../../xsds/DepositoChequeGerencia/DepositoChequeGerencia.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadechequedegerenciaFCY" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoChequeGerencia";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeGerencia/consultaChequeGerenciaFCYIn/";

declare function xf:consultaChequeGerenciaFCYIn($username as xs:string,
    $password as xs:string,
    $depositoChequeGerencia1 as element(ns1:depositoChequeGerencia),
    $nostroAccount)
    as element(ns0:ConsultadechequedegerenciaFCY) {
        <ns0:ConsultadechequedegerenciaFCY>
            <WebRequestCommon>
                <userName>{ $username }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <FICOHNFCYDRAFTDETAILSWSType>
                <enquiryInputCollection>
                    <columnName>CHEQUE.NUMBER</columnName>
                    <criteriaValue>{ data($depositoChequeGerencia1/CHEQUE_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
	            <enquiryInputCollection>
	               <columnName>CURRENCY</columnName>
	               <criteriaValue>{ fn:upper-case(data($depositoChequeGerencia1/CURRENCY)) }</criteriaValue>
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

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $depositoChequeGerencia1 as element(ns1:depositoChequeGerencia) external;
declare variable $nostroAccount as xs:string external;

xf:consultaChequeGerenciaFCYIn( $username,
    $password,
    $depositoChequeGerencia1,
    $nostroAccount)