(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaReciboRecaudo" element="ns1:consultaReciboRecaudo" location="../../xsds/ConsultaReciboRecaudo/ConsultaReciboRecaudo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadereciboderecaudo" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaReciboRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaReciboRecaudo/ConsultaReciboRecaudoIn/";

declare function xf:ConsultaReciboRecaudoIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaReciboRecaudo as element(ns1:consultaReciboRecaudo))
    as element(ns0:Consultadereciboderecaudo) {
        <ns0:Consultadereciboderecaudo>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <LATAMAGEDSLIPREPRINTWEBType>
            	{ 
            		let $TRANSACTION_ID := fn:string($consultaReciboRecaudo/TRANSACTION_ID/text())
            		return
            			if($TRANSACTION_ID != "") then (
	            			<enquiryInputCollection>
	            				<columnName>@ID</columnName>
	            				<criteriaValue>{ $TRANSACTION_ID }</criteriaValue>
	            				<operand>EQ</operand>
	            			</enquiryInputCollection>	
            			) else ()
                }
            	{ 
            		let $SERVICE_ID := fn:string($consultaReciboRecaudo/SERVICE_ID/text())
            		return
            			if($SERVICE_ID != "") then (
            				<enquiryInputCollection>
	            				<columnName>SERVICE.ID</columnName>
	            				<criteriaValue>{ $SERVICE_ID }</criteriaValue>
	            				<operand>EQ</operand>
	            			</enquiryInputCollection>	            				
            			) else ()
                }
            	{ 
            		let $PAYMENT_CODE := fn:string($consultaReciboRecaudo/PAYMENT_CODE/text())
            		return
            			if($PAYMENT_CODE != "") then (
            				<enquiryInputCollection>
	            				<columnName>PYMT.CODE</columnName>
	            				<criteriaValue>{ $PAYMENT_CODE }</criteriaValue>
	            				<operand>EQ</operand>
	            			</enquiryInputCollection>	            				
            			) else ()
                }
                                                                        	{ 
            		let $TRANSACTION_DATE := fn:string($consultaReciboRecaudo/TRANSACTION_DATE/text())
            		return
            			if($TRANSACTION_DATE != "") then (
            				<enquiryInputCollection>
	            				<columnName>TXN.DATE</columnName>
	            				<criteriaValue>{ $TRANSACTION_DATE }</criteriaValue>
	            				<operand>EQ</operand>
	            			</enquiryInputCollection>	            				
            			) else ()
                }
            </LATAMAGEDSLIPREPRINTWEBType>                
        </ns0:Consultadereciboderecaudo>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaReciboRecaudo as element(ns1:consultaReciboRecaudo) external;

xf:ConsultaReciboRecaudoIn($autenticacionRequestHeader,
    $consultaReciboRecaudo)