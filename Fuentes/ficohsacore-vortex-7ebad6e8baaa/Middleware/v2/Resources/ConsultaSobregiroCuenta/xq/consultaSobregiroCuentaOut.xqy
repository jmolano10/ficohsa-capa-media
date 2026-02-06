xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultadetsobregiroufranticipoResponse1" element="ns0:ConsultadetsobregiroufranticipoResponse" location="../../../../Business_Resources/consultaDetallePD/Resources/XMLSchema_865025152.xsd" ::)
(:: pragma  parameter="$conversionList" type="xs:anyType" ::)
(:: pragma bea:global-element-return element="ns1:consultaSobregiroCuentaResponse" location="../xsd/consultaSobregiroCuentaTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSobregiroCuenta/xq/consultaSobregiroCuentaOut2/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSobregiroCuentaTypes";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:consultaSobregiroCuentaOut2($consultadetsobregiroufranticipoResponse1 as element(ns0:ConsultadetsobregiroufranticipoResponse),
    $t24Account as xs:string,
    $conversionList as element(*))
    as element(ns1:consultaSobregiroCuentaResponse) {
		<ns1:consultaSobregiroCuentaResponse>
            {
                for $GRANDTOTALAMOUNT in $consultadetsobregiroufranticipoResponse1/FICOEPDCATEGLISTWSType[1]/GRANDTOTALAMOUNT
                return
                    <GRAND_TOTAL_AMOUNT>{ data($GRANDTOTALAMOUNT) }</GRAND_TOTAL_AMOUNT>
            }
            {
                for $CUSTOMERID in $consultadetsobregiroufranticipoResponse1/FICOEPDCATEGLISTWSType[1]/gFICOEPDCATEGLISTWSDetailType/mFICOEPDCATEGLISTWSDetailType[1]/CUSTOMERID
                return
                    <CUSTOMER_ID>{ data($CUSTOMERID) }</CUSTOMER_ID>
            }
            <ACCOUNT_NO>{ $t24Account }</ACCOUNT_NO>
            {
                for $CUSTOMERNAME in $consultadetsobregiroufranticipoResponse1/FICOEPDCATEGLISTWSType[1]/gFICOEPDCATEGLISTWSDetailType/mFICOEPDCATEGLISTWSDetailType[1]/CUSTOMERNAME
                return
                    <CUSTOMER_NAME>{ data($CUSTOMERNAME) }</CUSTOMER_NAME>
            }
            {
            	let $cutomerId  := ($consultadetsobregiroufranticipoResponse1/FICOEPDCATEGLISTWSType[1]/gFICOEPDCATEGLISTWSDetailType/mFICOEPDCATEGLISTWSDetailType/CUSTOMERID)  
                let $pdReference  := ($consultadetsobregiroufranticipoResponse1/FICOEPDCATEGLISTWSType[1]/gFICOEPDCATEGLISTWSDetailType/mFICOEPDCATEGLISTWSDetailType/PDREFERENCE)  
                let $pdAmount  := ($consultadetsobregiroufranticipoResponse1/FICOEPDCATEGLISTWSType[1]/gFICOEPDCATEGLISTWSDetailType/mFICOEPDCATEGLISTWSDetailType/PDAMOUNT)  
                let $category  := ($consultadetsobregiroufranticipoResponse1/FICOEPDCATEGLISTWSType[1]/gFICOEPDCATEGLISTWSDetailType/mFICOEPDCATEGLISTWSDetailType/CATEGORY)  
                let $pdDate  := ($consultadetsobregiroufranticipoResponse1/FICOEPDCATEGLISTWSType[1]/gFICOEPDCATEGLISTWSDetailType/mFICOEPDCATEGLISTWSDetailType/PDDATE)  
                let $pdStatus  := ($consultadetsobregiroufranticipoResponse1/FICOEPDCATEGLISTWSType[1]/gFICOEPDCATEGLISTWSDetailType/mFICOEPDCATEGLISTWSDetailType/PDSTATUS)  
                let $rate  := ($consultadetsobregiroufranticipoResponse1/FICOEPDCATEGLISTWSType[1]/gFICOEPDCATEGLISTWSDetailType/mFICOEPDCATEGLISTWSDetailType/RATE)  
                let $principal  := ($consultadetsobregiroufranticipoResponse1/FICOEPDCATEGLISTWSType[1]/gFICOEPDCATEGLISTWSDetailType/mFICOEPDCATEGLISTWSDetailType/PRINCIPAL)  
                let $interest  := ($consultadetsobregiroufranticipoResponse1/FICOEPDCATEGLISTWSType[1]/gFICOEPDCATEGLISTWSDetailType/mFICOEPDCATEGLISTWSDetailType/INTERESTS)  
                let $daysInPd  := ($consultadetsobregiroufranticipoResponse1/FICOEPDCATEGLISTWSType[1]/gFICOEPDCATEGLISTWSDetailType/mFICOEPDCATEGLISTWSDetailType/NOOFDAYSINPD)  
                return
                for $i  in (1 to count($cutomerId))  
                return                                                   
                	if (data($cutomerId[$i]) != "") then(   
                		<DETAILS>                        		
	                    	<REFERENCE>{ data($pdReference[$i]) }</REFERENCE>
	                        <AMOUNT>{ data($pdAmount[$i]) }</AMOUNT>
	                        <OVERDRAFT_TYPE>{ fn:string($conversionList/CONVERSIONS/CONVERSION[BUSINESS_VALUE = data($category[$i])]/PROXY_VALUE/text()) }</OVERDRAFT_TYPE>
	                        <RATE>{ data($rate[$i]) }</RATE>
	                        <ACTIVITY_DETAILS>
	                        {
	                            if (count(tokenize($pdDate[$i], "\|\|")) > 1) then (
	                            	let $sequencePdDate  := (tokenize($pdDate[$i], "\|\|"))  
	                                let $sequencePdStatus  := (tokenize($pdStatus[$i], "\|\|"))  
	                                let $sequenceInterest  := (tokenize($interest[$i], "\|\|"))  
	                                let $sequencePrincipal  := (tokenize($principal[$i], "\|\|"))  
	                                let $sequenceDaysInPd  := (tokenize($daysInPd[$i], "\|\|"))  
	                                for $j  in (1 to count($sequencePdDate))  
	                                return
	                                	<ACTIVITY_DETAIL>                                    
	                                    	<DATE>{ data($sequencePdDate[$j]) }</DATE>
	                                    	<STATUS>{ data($sequencePdStatus[$j]) }</STATUS>
	                                    	<PRINCIPAL>{ data($sequencePrincipal[$j]) }</PRINCIPAL>
	                                    	<INTEREST>{ data($sequenceInterest[$j]) }</INTEREST>
	                                    	<DAYS>{ data($sequenceDaysInPd[$j]) }</DAYS>
	                                    </ACTIVITY_DETAIL>
	                             )
	                             else( 
	                             	<ACTIVITY_DETAIL>                     
	                                	<DATE>{ data($pdDate[$i]) }</DATE>
	                                	<STATUS>{ data($pdStatus[$i]) }</STATUS>
	                                	<PRINCIPAL>{ data($principal[$i]) }</PRINCIPAL>
	                                	<INTEREST>{ data($interest[$i]) }</INTEREST>
	                                	<DAYS>{ data($daysInPd[$i]) }</DAYS>
	                                </ACTIVITY_DETAIL>
	                             )
	                          }
	                          </ACTIVITY_DETAILS> 
                       	  </DETAILS>                           	
                       )else()                                    
        	}
            
        </ns1:consultaSobregiroCuentaResponse>
};

declare variable $consultadetsobregiroufranticipoResponse1 as element(ns0:ConsultadetsobregiroufranticipoResponse) external;
declare variable $t24Account as xs:string external;
declare variable $conversionList as element(*) external;

xf:consultaSobregiroCuentaOut2($consultadetsobregiroufranticipoResponse1,
    $t24Account,
    $conversionList)