(:: pragma bea:global-element-parameter parameter="$consultadetsobregiroufranticipoResponse1" element="ns0:ConsultadetsobregiroufranticipoResponse" location="Resources/XMLSchema_865025152.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetallePDResponse" location="consultaDetallePDTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetallePDTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaDetallePD/consultaDetallePDOut2/";

declare function xf:consultaDetallePDOut2($consultadetsobregiroufranticipoResponse1 as element(ns0:ConsultadetsobregiroufranticipoResponse),
    $string1 as xs:string)
    as element(ns1:consultaDetallePDResponse) {
        <ns1:consultaDetallePDResponse>
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
            <ACCOUNT_NO>{ $string1 }</ACCOUNT_NO>
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
                		<PD_DETAILS>                        		
	                    	<PD_REFERENCE>{ data($pdReference[$i]) }</PD_REFERENCE>
	                        <PD_AMOUNT>{ data($pdAmount[$i]) }</PD_AMOUNT>
	                        <CATEGORY>{ data($category[$i]) }</CATEGORY>
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
	                                    	<PD_DATE>{ data($sequencePdDate[$j]) }</PD_DATE>
	                                    	<PD_STATUS>{ data($sequencePdStatus[$j]) }</PD_STATUS>
	                                    	<PRINCIPAL>{ data($sequencePrincipal[$j]) }</PRINCIPAL>
	                                    	<INTEREST>{ data($sequenceInterest[$j]) }</INTEREST>
	                                    	<DAYS_IN_PD>{ data($sequenceDaysInPd[$j]) }</DAYS_IN_PD>
	                                    </ACTIVITY_DETAIL>
	                             )
	                             else( 
	                             	<ACTIVITY_DETAIL>                     
	                                	<PD_DATE>{ data($pdDate[$i]) }</PD_DATE>
	                                	<PD_STATUS>{ data($pdStatus[$i]) }</PD_STATUS>
	                                	<PRINCIPAL>{ data($principal[$i]) }</PRINCIPAL>
	                                	<INTEREST>{ data($interest[$i]) }</INTEREST>
	                                	<DAYS_IN_PD>{ data($daysInPd[$i]) }</DAYS_IN_PD>
	                                </ACTIVITY_DETAIL>
	                             )
	                          }
	                          </ACTIVITY_DETAILS> 
                       	  </PD_DETAILS>                           	
                       )else()                                    
        	}
        </ns1:consultaDetallePDResponse>
};

declare variable $consultadetsobregiroufranticipoResponse1 as element(ns0:ConsultadetsobregiroufranticipoResponse) external;
declare variable $string1 as xs:string external;

xf:consultaDetallePDOut2($consultadetsobregiroufranticipoResponse1,
    $string1)