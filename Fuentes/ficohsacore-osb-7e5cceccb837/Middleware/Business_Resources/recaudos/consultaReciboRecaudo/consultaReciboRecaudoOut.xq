(:: pragma bea:global-element-parameter parameter="$consultadereciboderecaudoResponse" element="ns0:ConsultadereciboderecaudoResponse" location="../Resources/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaReciboRecaudoResponse" location="consultaReciboRecaudoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaReciboRecaudoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaReciboRecaudo/consultaReciboRecaudoOut/";

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

declare function xf:consultaReciboRecaudoOut($consultadereciboderecaudoResponse as element(ns0:ConsultadereciboderecaudoResponse))
    as element(ns1:consultaReciboRecaudoResponse) {
        <ns1:consultaReciboRecaudoResponse>
        	{
        		for $registro in $consultadereciboderecaudoResponse/LATAMAGEDSLIPREPRINTWEBType[1]/gLATAMAGEDSLIPREPRINTWEBDetailType/mLATAMAGEDSLIPREPRINTWEBDetailType[TAGNAME="dealslip"][1]
            		return (
						<TRANSACTION_ID>{ data($registro/TRANSACTIONID) }</TRANSACTION_ID>,
						<SERVICE_ID>{ data($registro/SERVICEID) }</SERVICE_ID>,
						<PAYMENT_CODE>{ data($registro/PAYMENTCODE) }</PAYMENT_CODE>,
						<REMITTANCE_KEY>{ data($registro/REMITTANCEKEY) }</REMITTANCE_KEY>,
						<TRANSACTION_DATE>{ data($registro/TRANSACTIONDATE) }</TRANSACTION_DATE>,
						<DEALSLIP>{ replace-multi($registro/TAGVALUES, ('&amp;#61', '&amp;#44'), ('=',',')) }</DEALSLIP>
				)
            }
        </ns1:consultaReciboRecaudoResponse>
};

declare variable $consultadereciboderecaudoResponse as element(ns0:ConsultadereciboderecaudoResponse) external;

xf:consultaReciboRecaudoOut($consultadereciboderecaudoResponse)