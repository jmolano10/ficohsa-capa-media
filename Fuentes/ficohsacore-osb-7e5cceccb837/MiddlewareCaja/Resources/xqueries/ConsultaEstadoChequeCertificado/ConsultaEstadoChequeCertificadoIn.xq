(:: pragma bea:global-element-parameter parameter="$consultaEstadoChequeCertificado" element="ns1:consultaEstadoChequeCertificado" location="../../xsds/ConsultaEstadoChequeCertificado/ConsultaEstadoChequeCertificado.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadechqcertificado" location="../../xsds/CertifCheque/XMLSchema_1194496794.xsd" ::)


declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoChequeCertificadoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaEstadoChequeCertificado/ConsultaEstadoChequeCertificadoIn/";

declare function xf:ConsultaEstadoChequeCertificadoIn($username as xs:string,
    $password as xs:string,
    $consultaEstadoChequeCertificado as element(ns1:consultaEstadoChequeCertificado))
    as element(ns0:Consultadechqcertificado) {
        <ns0:Consultadechqcertificado>
            <WebRequestCommon>
                <userName>{ $username  }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <FICOCERTCHQSTATUSType>
                <enquiryInputCollection>
                    <columnName>DEBIT.ACCT.NO</columnName>
                    <criteriaValue>{ data($consultaEstadoChequeCertificado/ACCOUNT_NUMBER) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
		        <enquiryInputCollection>
		            <columnName>CHEQUE.NO</columnName>
		            <criteriaValue>{ data($consultaEstadoChequeCertificado/CHEQUE_NUMBER) }</criteriaValue>
		            <operand>EQ</operand>
		        </enquiryInputCollection>                
            </FICOCERTCHQSTATUSType>            
        </ns0:Consultadechqcertificado>
};


declare variable $consultaEstadoChequeCertificado as element(ns1:consultaEstadoChequeCertificado) external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;

xf:ConsultaEstadoChequeCertificadoIn($username,
    $password,
    $consultaEstadoChequeCertificado)