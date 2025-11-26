(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns1:consultaRecaudo" location="../../xsds/ConsultaRecaudo/ConsultaRecaudo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadedetallederecaudo" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoIn/";

(:: Equivalente a un NVL en Oracle:)
declare function if-absent 
  ( $arg as item()* ,
    $value as item()* )  as item()* {
       
    if (exists($arg))
    then $arg
    else $value
 } ;
 
(:: Realiza un replcae multiple :)
declare function replace-multi 
  ( $arg as xs:string? ,
    $changeFrom as xs:string* ,
    $changeTo as xs:string* )  as xs:string? {
       
   if (count($changeFrom) > 0)
   then replace-multi(
          replace($arg, $changeFrom[1],
                     if-absent($changeTo[1],'')),
          $changeFrom[position() > 1],
          $changeTo[position() > 1])
   else $arg
 } ;

declare function xf:consultaRecaudoIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaRecaudo as element(ns1:consultaRecaudo))
    as element(ns0:Consultadedetallederecaudo) {
        <ns0:Consultadedetallederecaudo>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <LATAMAGWSPENDINGBILLSType>
                <enquiryInputCollection>
                    <columnName>AGR.CONTRACT.ID</columnName>
                    <criteriaValue>{ data($consultaRecaudo/CONTRACT_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>DEBTOR.CODE</columnName>
                    <criteriaValue>{ replace-multi(data($consultaRecaudo/DEBTOR_CODE),"Ñ","#") }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>TXN.CCY</columnName>
                    <criteriaValue>{ data($consultaRecaudo/CURRENCY) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                {
                	let $BILL_RETURN_TYPE := fn:string($consultaRecaudo/BILL_RETURN_TYPE/text())
                	return 
	                	if( $BILL_RETURN_TYPE = "ONE" ) then (
			                <enquiryInputCollection>
			                    <columnName>CHANNEL.IND</columnName>
			                    <criteriaValue>ATM</criteriaValue>
			                    <operand>EQ</operand>
			                </enquiryInputCollection>
			        	) else if( $BILL_RETURN_TYPE = "ALL" ) then (
			                <enquiryInputCollection>
			                    <columnName>CHANNEL.IND</columnName>
			                    <criteriaValue>OTHER</criteriaValue>
			                    <operand>EQ</operand>
			                </enquiryInputCollection>
			        	) else ()
                }                                                
            </LATAMAGWSPENDINGBILLSType>
        </ns0:Consultadedetallederecaudo>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaRecaudo as element(ns1:consultaRecaudo) external;

xf:consultaRecaudoIn($autenticacionRequestHeader,
    $consultaRecaudo)