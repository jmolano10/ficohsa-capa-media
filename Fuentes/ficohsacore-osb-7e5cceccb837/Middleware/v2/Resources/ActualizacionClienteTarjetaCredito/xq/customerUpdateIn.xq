(:: pragma bea:global-element-parameter parameter="$actualizacionClienteTarjetaCredito" element="ns1:actualizacionClienteTarjetaCredito" location="../xsd/actualizacionClienteTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CustomerUpdateL8V2Request" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$ptEquivalencias" type="ns2:OutputParameters/ns2:PT_EQUIVALENCIAS" location="../../../BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizacionClienteTarjetaCreditoTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizacionClienteTarjetaCredito/xq/customerUpdateIn/";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEquivalenciasCatalogos";

declare function valorCatalogoOSBToAPP($valor as xs:string,
	$aplicacion as xs:string,
	$catalogoId as xs:string,
	$equivalencias as element(*)
) as xs:string {
	let $retorno := fn:string($equivalencias/ns2:EQUIVALENCIA[ns2:CATALOGO_ID = $catalogoId and 
															  ns2:APLICACION_DESC = $aplicacion and 
															  ns2:VALOR_DESC = $valor]/ns2:EQUIVALENCIA_DESC/text())
	return
		if($retorno != "") then (
			$retorno
		) else (
			$valor
		)
};

declare function xf:customerUpdateIn($actualizacionClienteTarjetaCredito as element(ns1:actualizacionClienteTarjetaCredito),$ptEquivalencias as element())
    as element(ns0:CustomerUpdateL8V2Request) {
        <ns0:CustomerUpdateL8V2Request>
            
            {
            	for $ORG in $actualizacionClienteTarjetaCredito/ORG
            	return
            		if(string($ORG/text()) != "") then (  
            			<AZXGCI-ORG>{ data($actualizacionClienteTarjetaCredito/ORG) }</AZXGCI-ORG>
            		) else (<AZXGCI-ORG xsi:nil="true"/>)	
            }
            {
            	for $PRODUCT_NUMBER in $actualizacionClienteTarjetaCredito/PRODUCT_NUMBER
            	return
            		if(string($PRODUCT_NUMBER/text()) != "") then (  
            			<AZXGCI-CARD-NBR>{ data($actualizacionClienteTarjetaCredito/PRODUCT_NUMBER) }</AZXGCI-CARD-NBR>
            		) else (<AZXGCI-CARD-NBR xsi:nil="true"/>)	
            }

            			<AZXGCI-NBR-TYPE>{ data($actualizacionClienteTarjetaCredito/PRODUCT_TYPE) }</AZXGCI-NBR-TYPE>
           				<AZXGCI-FOREIGN-USE>{ data($actualizacionClienteTarjetaCredito/FOREIGN_INDICATOR) }</AZXGCI-FOREIGN-USE> 
            			<AZXGCI-DEMOGRAPHIC-DATAIND>{ data($actualizacionClienteTarjetaCredito/DEMOGRAPHIC_DATA_INDICATOR) }</AZXGCI-DEMOGRAPHIC-DATAIND>
            			<AZXGCI-USER-DATA-IND>{ data($actualizacionClienteTarjetaCredito/USER_DATA_INDICATOR) }</AZXGCI-USER-DATA-IND>
       
            {
            	for $VIP_STATUS in $actualizacionClienteTarjetaCredito/VIP_STATUS
            	return
            		if(string($VIP_STATUS/text()) != "") then (  
            			<AZXGCI-VIP-STATUS>{ data($actualizacionClienteTarjetaCredito/VIP_STATUS) }</AZXGCI-VIP-STATUS>
            		) else (<AZXGCI-VIP-STATUS xsi:nil="true"/>)	
            }
            {
            	for $CUSTOMER_STATUS in $actualizacionClienteTarjetaCredito/CUSTOMER_STATUS
            	return
            		if(string($CUSTOMER_STATUS/text()) != "") then (  
            			<AZXGCI-STATUS>{ data($actualizacionClienteTarjetaCredito/CUSTOMER_STATUS) }</AZXGCI-STATUS>
            		) else (<AZXGCI-STATUS xsi:nil="true"/>)	
            }
            	<AZXGCI-SIC-CODE xsi:nil="true" />
            	<AZXGCI-TITLE xsi:nil="true" />	
            	           
            {
            	let $MARITAL_STATUS := string($actualizacionClienteTarjetaCredito/MARITAL_STATUS/text())
            	return
            		if($MARITAL_STATUS != "") then (  
            			<AZXGCI-MARITAL-STATUS>{ valorCatalogoOSBToAPP($MARITAL_STATUS, 'VISION+', '2', $ptEquivalencias) }</AZXGCI-MARITAL-STATUS>
            		) else (<AZXGCI-MARITAL-STATUS xsi:nil="true" />)	
            }
            
            {
            	let $NAME_1 := fn:replace(data($actualizacionClienteTarjetaCredito/NAME_1),"[Ññ]", "#")
            	return
            		if($NAME_1 != "") then (  
            			<AZXGCI-NAME-LINE-1>{ $NAME_1 }</AZXGCI-NAME-LINE-1>
            		) else (<AZXGCI-NAME-LINE-1 xsi:nil="true" />)	
            }            	        
        	{
            	let $TYPE_NAME_1 := string($actualizacionClienteTarjetaCredito/TYPE_NAME_1/text())
            	return
            		if($TYPE_NAME_1 != "") then (  
            			<AZXGCI-NAME-LINE-1-TYP>{ $TYPE_NAME_1 }</AZXGCI-NAME-LINE-1-TYP>
            		) else (<AZXGCI-NAME-LINE-1-TYP xsi:nil="true" />)	
            }
            
            {
            	let $NAME_2 := fn:replace(data($actualizacionClienteTarjetaCredito/NAME_2),"[Ññ]", "#")
            	return
            		if($NAME_2 != "") then (  
            			<AZXGCI-NAME-LINE-2>{ $NAME_2 }</AZXGCI-NAME-LINE-2>
            		) else (<AZXGCI-NAME-LINE-2 xsi:nil="true" />)	
            } 	            	
 			{
            	let $TYPE_NAME_2 := string($actualizacionClienteTarjetaCredito/TYPE_NAME_2/text())
            	return
            		if($TYPE_NAME_2!= "") then (  
            			<AZXGCI-NAME-LINE-2-TYP>{ $TYPE_NAME_2 }</AZXGCI-NAME-LINE-2-TYP>
            		) else (<AZXGCI-NAME-LINE-2-TYP xsi:nil="true" />)	
            }
            
            {
            	let $NAME_3 := fn:replace(data($actualizacionClienteTarjetaCredito/NAME_3),"[Ññ]", "#")
            	return
            		if($NAME_3 != "") then (  
            			<AZXGCI-NAME-LINE-3>{ $NAME_3 }</AZXGCI-NAME-LINE-3>
            		) else (<AZXGCI-NAME-LINE-3 xsi:nil="true" />)	
            } 		
 				            	  
            {
            	let $TYPE_NAME_3 := string($actualizacionClienteTarjetaCredito/TYPE_NAME_3/text())
            	return
            		if($TYPE_NAME_3 != "") then (  
            			<AZXGCI-NAME-LINE-3-TYP>{ $TYPE_NAME_3 }</AZXGCI-NAME-LINE-3-TYP>
            		) else (<AZXGCI-NAME-LINE-3-TYP xsi:nil="true" />)	
            }	
        		<AZXGCI-HOUSE-NBR  xsi:nil="true" /> 
            	<AZXGCI-HOUSE-NAME   xsi:nil="true" />
            {
            	let $HOME_ADDRESS_LINE_1 := fn:replace(string($actualizacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_1/text()),"[Ññ]", "#")
            	return
            		if($HOME_ADDRESS_LINE_1 != "") then (  
            			<AZXGCI-ADDR-1>{ $HOME_ADDRESS_LINE_1 }</AZXGCI-ADDR-1>
            		) else (<AZXGCI-ADDR-1 xsi:nil="true" />)	
            }
            {
            	let $HOME_ADDRESS_LINE_2 := fn:replace(string($actualizacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_2/text()),"[Ññ]", "#")
            	return
            		if($HOME_ADDRESS_LINE_2 != "") then (  
            			<AZXGCI-ADDR-2>{ $HOME_ADDRESS_LINE_2 }</AZXGCI-ADDR-2>
            		) else (<AZXGCI-ADDR-2 xsi:nil="true" />)	
            }
            {
            	let $HOME_ADDRESS_LINE_3 := fn:replace(string($actualizacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_3/text()),"[Ññ]", "#")
            	return
            		if($HOME_ADDRESS_LINE_3 != "") then (  
            			<AZXGCI-ADDR-3>{ $HOME_ADDRESS_LINE_3 }</AZXGCI-ADDR-3>
            		) else (<AZXGCI-ADDR-3 xsi:nil="true" />)	
            }
            {
            	let $HOME_ADDRESS_LINE_4 := fn:replace(string($actualizacionClienteTarjetaCredito/HOME_ADDRESS/HOME_ADDRESS_LINE_4/text()),"[Ññ]", "#")
            	return
            		if($HOME_ADDRESS_LINE_4 != "") then (  
            			<AZXGCI-ADDR-4>{ $HOME_ADDRESS_LINE_4 }</AZXGCI-ADDR-4>
            		) else (<AZXGCI-ADDR-4 xsi:nil="true" />)	
            }          
            {
            	let $CITY := string($actualizacionClienteTarjetaCredito/CITY/text())
            	return
            		if($CITY != "") then (  
            			<AZXGCI-CITY>{ $CITY }</AZXGCI-CITY>
            		) else (<AZXGCI-CITY xsi:nil="true" />)	
            }
            {
            	let $STATE := string($actualizacionClienteTarjetaCredito/STATE/text())
            	return
            		if($STATE != "") then (  
            			<AZXGCI-STATE>{ valorCatalogoOSBToAPP($STATE, 'VISION+', '35', $ptEquivalencias) }</AZXGCI-STATE>
            		) else (<AZXGCI-STATE xsi:nil="true" />)	
            }
            {
            	let $ZIP_CODE := string($actualizacionClienteTarjetaCredito/ZIP_CODE/text())
            	return
            		if($ZIP_CODE != "") then (  
            			<AZXGCI-PSTL-CD>{ $ZIP_CODE }</AZXGCI-PSTL-CD>
            		) else (<AZXGCI-PSTL-CD xsi:nil="true" />)	
            }
            {
            	let $COUNTRY_OF_RESIDENCE := string($actualizacionClienteTarjetaCredito/COUNTRY_OF_RESIDENCE/text())
            	return
            		if($COUNTRY_OF_RESIDENCE != "") then (  
            			<AZXGCI-CNTRY-CD>{ $COUNTRY_OF_RESIDENCE }</AZXGCI-CNTRY-CD>
            		) else (<AZXGCI-CNTRY-CD xsi:nil="true" />)	
            }
            {
            	let $RESIDENCE_TYPE := string($actualizacionClienteTarjetaCredito/RESIDENCE_TYPE/text())
            	return
            		if($RESIDENCE_TYPE != "") then (  
            			<AZXGCI-OWN-RENT-RESID-FLAG>{ $RESIDENCE_TYPE}</AZXGCI-OWN-RENT-RESID-FLAG>
            		) else (<AZXGCI-OWN-RENT-RESID-FLAG xsi:nil="true" />)	
            }
            {
            	let $LANGUAGE := string($actualizacionClienteTarjetaCredito/LANGUAGE/text())
            	return
            		if($LANGUAGE != "") then (  
            			<AZXGCI-LANGUAGE-IND>{ $LANGUAGE }</AZXGCI-LANGUAGE-IND>
            		) else (<AZXGCI-LANGUAGE-IND xsi:nil="true" />)	
            }
            (:Validacion para campo MAILING-LIST:)
        	{
        		let $MAILING_LIST := fn:string($actualizacionClienteTarjetaCredito/MAILING_LIST/text())
        		return
        			if($MAILING_LIST != "") then(
        				<AZXGCI-MAILING-LIST>{ data($MAILING_LIST) }</AZXGCI-MAILING-LIST>		
        			)else(
        				<AZXGCI-MAILING-LIST>E</AZXGCI-MAILING-LIST>
        			)
        	}
        	(:Validacion para campo MAILING-LIST:)
            {
            	let $CONTACT_INDICATOR := string($actualizacionClienteTarjetaCredito/CONTACT_INDICATOR/text())
            	return
            		if($CONTACT_INDICATOR != "") then (  
            			<AZXGCI-CONTACT-IND>{ $CONTACT_INDICATOR }</AZXGCI-CONTACT-IND>
            		) else (<AZXGCI-CONTACT-IND xsi:nil="true" />)	
            }
                        {
            	let $GENDER := string($actualizacionClienteTarjetaCredito/GENDER/text())
            	return
            		if($GENDER != "") then (  
            			<AZXGCI-GENDER-CODE>{ valorCatalogoOSBToAPP($GENDER, 'VISION+', '1', $ptEquivalencias) }</AZXGCI-GENDER-CODE>
            		) else (<AZXGCI-GENDER-CODE xsi:nil="true" />)	
            }
            {
            	let $HOME_PHONE_NUMBER := string($actualizacionClienteTarjetaCredito/HOME_PHONE_NUMBER/text())
            	return
            		if($HOME_PHONE_NUMBER != "") then (  
            			<AZXGCI-HOME-PHONE>{ $HOME_PHONE_NUMBER }</AZXGCI-HOME-PHONE>
            		) else (<AZXGCI-HOME-PHONE xsi:nil="true" />)	
            }
            	<AZXGCI-HOME-PHONE-IND xsi:nil="true" />
            {
            	let $FAX_PHONE := string($actualizacionClienteTarjetaCredito/FAX_PHONE/text())
            	return
            		if($FAX_PHONE != "") then (  
            			<AZXGCI-FAX-PHONE>{ $FAX_PHONE }</AZXGCI-FAX-PHONE>
            		) else (<AZXGCI-FAX-PHONE xsi:nil="true" />)	
            }
            {
            	let $PHONE_INDICATOR := string($actualizacionClienteTarjetaCredito/PHONE_INDICATOR/text())
            	return
            		if($PHONE_INDICATOR != "") then (  
            			<AZXGCI-FAX-PHONE-IND>{ $PHONE_INDICATOR }</AZXGCI-FAX-PHONE-IND>
            		) else (<AZXGCI-FAX-PHONE-IND xsi:nil="true" />)	
            }
            {
            	let $MOBILE_PHONE := string($actualizacionClienteTarjetaCredito/MOBILE_PHONE/text())
            	return
            		if($MOBILE_PHONE != "") then (  
            			<AZXGCI-MOBILE-PHONE>{ $MOBILE_PHONE }</AZXGCI-MOBILE-PHONE>
            		) else (<AZXGCI-MOBILE-PHONE xsi:nil="true" />)	
            }
            {
            	let $MOBILE_INDICATOR := string($actualizacionClienteTarjetaCredito/MOBILE_INDICATOR/text())
            	return
            		if($MOBILE_INDICATOR != "") then (  
            			<AZXGCI-MOBILE-PHONE-IND>{ $MOBILE_INDICATOR }</AZXGCI-MOBILE-PHONE-IND>
            		) else (<AZXGCI-MOBILE-PHONE-IND xsi:nil="true" />)	
            }
            { 
            	let $birthDate := string($actualizacionClienteTarjetaCredito/BIRTH_DATE/text())
            	return
            		if($birthDate != "") then(
            			<AZXGCI-DOB>{fn-bea:date-to-string-with-format('yyyyDDD', xs:date($birthDate))}</AZXGCI-DOB>
            		)else(<AZXGCI-DOB xsi:nil="true" />) 
            }
            <AZXGCI-DL-CNTRY xsi:nil="true" />
            <AZXGCI-DL-STATE  xsi:nil="true" />
            {
            	let $DRIVERS_LICENSE := string($actualizacionClienteTarjetaCredito/DRIVERS_LICENSE/text())
            	return
            		if($DRIVERS_LICENSE != "") then (  
            			<AZXGCI-DL-NBR>{ $DRIVERS_LICENSE }</AZXGCI-DL-NBR>
            		) else (<AZXGCI-DL-NBR xsi:nil="true" />)	
            }        
            <AZXGCI-TAX-ID-TYP xsi:nil="true" />
            <AZXGCI-TAX-ID xsi:nil="true" />
            <AZXGCI-1099C-W9-DATE-FILED xsi:nil="true" />
            {
            	let $WORKPLACE := string($actualizacionClienteTarjetaCredito/WORKPLACE/text())
            	return
            		if($WORKPLACE != "") then (  
            			<AZXGCI-EMPLOYER>{ $WORKPLACE }</AZXGCI-EMPLOYER>
            		) else (<AZXGCI-EMPLOYER xsi:nil="true" />)	
            }
            {
            	let $WORK_ADDRESS_1 := fn:replace(string($actualizacionClienteTarjetaCredito/WORK_ADDRESS/WORK_ADDRESS_1/text()),"[Ññ]", "#")
            	return
            		if($WORK_ADDRESS_1 != "") then (  
            			<AZXGCI-EMPLOYER-ADDR-1>{ data($WORK_ADDRESS_1) }</AZXGCI-EMPLOYER-ADDR-1>
            		) else (<AZXGCI-EMPLOYER-ADDR-1 xsi:nil="true" />)	
            }
            {
            	let $WORK_ADDRESS_2 := fn:replace(string($actualizacionClienteTarjetaCredito/WORK_ADDRESS/WORK_ADDRESS_2/text()),"[Ññ]", "#")
            	return
            		if($WORK_ADDRESS_2 != "") then (  
            			<AZXGCI-EMPLOYER-ADDR-2>{ $WORK_ADDRESS_2 }</AZXGCI-EMPLOYER-ADDR-2>
            		) else (<AZXGCI-EMPLOYER-ADDR-2 xsi:nil="true" />)	
            }
            {
            	let $WORK_PHONE_NUMBER := string($actualizacionClienteTarjetaCredito/WORK_PHONE_NUMBER/text())
            	return
            		if($WORK_PHONE_NUMBER != "") then (  
            			<AZXGCI-EMP-PHONE>{ $WORK_PHONE_NUMBER }</AZXGCI-EMP-PHONE>
            		) else (<AZXGCI-EMP-PHONE xsi:nil="true" />)	
            }
            {
            	let $WORK_EXTENSION := string($actualizacionClienteTarjetaCredito/WORK_EXTENSION/text())
            	return
            		if($WORK_EXTENSION != "") then (  
            			<AZXGCI-EMP-PHONE-EXTN>{ $WORK_EXTENSION }</AZXGCI-EMP-PHONE-EXTN>
            		) else (<AZXGCI-EMP-PHONE-EXTN xsi:nil="true" />)	
            }
            <AZXGCI-EMP-PHONE-FLAG  xsi:nil="true" />
            {
            	let $PROFESSION := string($actualizacionClienteTarjetaCredito/PROFESSION/text())
            	return
            		if($PROFESSION != "") then (  
            			<AZXGCI-POSITION>{ valorCatalogoOSBToAPP($PROFESSION, 'VISION+', '3', $ptEquivalencias) }</AZXGCI-POSITION>     	
            		) else (<AZXGCI-POSITION xsi:nil="true" />)		
            }
            
            {
            	let $WORK_ECONOMIC_ACTIVITY := string($actualizacionClienteTarjetaCredito/WORK_ECONOMIC_ACTIVITY/text())
            	return
            		if($WORK_ECONOMIC_ACTIVITY != "") then (  
            			<AZXGCI-RELATIVE-NAME>{ $WORK_ECONOMIC_ACTIVITY }</AZXGCI-RELATIVE-NAME>
            		) else (<AZXGCI-RELATIVE-NAME xsi:nil="true" />)	
            }
            {
            	let $DEPENDENTS := string($actualizacionClienteTarjetaCredito/DEPENDENTS/text())
            	return
            		if($DEPENDENTS != "") then (  
            			<AZXGCI-NBR-OF-DEPENDENTS>{ $DEPENDENTS }</AZXGCI-NBR-OF-DEPENDENTS>
            		) else (<AZXGCI-NBR-OF-DEPENDENTS xsi:nil="true" />)	
            }
            {
            	let $EMAIL := string($actualizacionClienteTarjetaCredito/EMAIL/text())
            	return
            		if($EMAIL != "") then (  
            			<AZXGCI-EMAIL>{ $EMAIL }</AZXGCI-EMAIL>
            		) else (<AZXGCI-EMAIL xsi:nil="true" />)	
            }
            <AZXGCI-EMAIL-IND   xsi:nil="true" />
            <AZXGCI-SMS-IND    xsi:nil="true" />
            {
            	let $NAMES := string($actualizacionClienteTarjetaCredito/NAMES/text())
            	let $NAMES_PROCESSED := fn:replace($NAMES,"[Ññ]", "#")
            	return
            		if($NAMES != "") then (  
            			<AZXGCI-FIRST-NAME>{ $NAMES_PROCESSED }</AZXGCI-FIRST-NAME>
            		) else (<AZXGCI-FIRST-NAME xsi:nil="true" />)	
            }
            <AZXGCI-MIDDLE-NAME xsi:nil="true" />
            {
            	let $LAST_NAMES := string($actualizacionClienteTarjetaCredito/LAST_NAMES/text())
            	let $LAST_NAMES_PROCESSED := fn:replace($LAST_NAMES,"[Ññ]", "#")
            	return
            		if($LAST_NAMES != "") then (  
            			<AZXGCI-LAST-NAME>{ $LAST_NAMES_PROCESSED }</AZXGCI-LAST-NAME>
            		) else (<AZXGCI-LAST-NAME xsi:nil="true" />)	
            }
            <AZXGCI-SUFFIX  xsi:nil="true" />
            {
            	let $HOME_MUNICIPALITY := data($actualizacionClienteTarjetaCredito/HOME_MUNICIPALITY)
            	return
            		if($HOME_MUNICIPALITY != "") then (  
            			<AZXGCI-COUNTY>{ $HOME_MUNICIPALITY }</AZXGCI-COUNTY>
            		) else (<AZXGCI-COUNTY xsi:nil="true" />)	
            }            
            {
            	let $MEMO-1 := concat(data($actualizacionClienteTarjetaCredito/COUNTRY_WORK),' ',data($actualizacionClienteTarjetaCredito/WORK_ADDRESS_3))
            	return
            		if($MEMO-1 != "") then (  
            			<AZXGCI-MEMO-1>{ fn:replace($MEMO-1,"[Ññ]", "#") }</AZXGCI-MEMO-1>
            		) else (<AZXGCI-MEMO-1 xsi:nil="true" />)	
            }
            {
            	let $MEMO-2:= concat(data($actualizacionClienteTarjetaCredito/WORK_STATE),' ',data($actualizacionClienteTarjetaCredito/WORK_ADDRESS_4))
            	return
            		if($MEMO-2 != "") then (  
            			<AZXGCI-MEMO-2>{ fn:replace($MEMO-2,"[Ññ]", "#") }</AZXGCI-MEMO-2>
            		) else (<AZXGCI-MEMO-2 xsi:nil="true" />)	
            }
            {
            	let $EMPLOYMENT_YEARS := string($actualizacionClienteTarjetaCredito/EMPLOYMENT_YEARS/text())
            	return
            		if($EMPLOYMENT_YEARS != "") then (  
            			<AZXGCI-USER-1>{ $EMPLOYMENT_YEARS }</AZXGCI-USER-1>
            		) else (<AZXGCI-USER-1 xsi:nil="true" />)	
            }
            {
            	let $EMPLOYMENT_MONTHS := string($actualizacionClienteTarjetaCredito/EMPLOYMENT_MONTHS/text())
            	return
            		if($EMPLOYMENT_MONTHS != "") then (  
            			<AZXGCI-USER-2>{ $EMPLOYMENT_MONTHS }</AZXGCI-USER-2>
            		) else (<AZXGCI-USER-2 xsi:nil="true" />)	
            }
            
            {
            	let $WORK_TITLE := string($actualizacionClienteTarjetaCredito/WORK_TITLE/text())
            	return
            		if($WORK_TITLE != "") then (  
            			<AZXGCI-USER-3>{ $WORK_TITLE }</AZXGCI-USER-3>     	
            		) else (<AZXGCI-USER-3 xsi:nil="true" />)	
            }	
                     
           {
            	let $SALARY_RANGE :=  data($actualizacionClienteTarjetaCredito/SALARY_RANGE)
            	return
            		if($SALARY_RANGE != "") then (  
            			<AZXGCI-USER-4>{ $SALARY_RANGE }</AZXGCI-USER-4>     	
            		) else (<AZXGCI-USER-4 xsi:nil="true" />)	
            }	                     
            {
            	let $NATURE_OF_BUSINESS := data($actualizacionClienteTarjetaCredito/NATURE_OF_BUSINESS)
            	return
            		if($NATURE_OF_BUSINESS != "") then (  
            			<AZXGCI-USER-5>{ $NATURE_OF_BUSINESS }</AZXGCI-USER-5>   	
            		) else (<AZXGCI-USER-5 xsi:nil="true" />)	
            }
            <AZXGCI-USER-6  xsi:nil="true" />
            <AZXGCI-USER-7  xsi:nil="true" />
            {
            	let $PEP_CLIENT := string($actualizacionClienteTarjetaCredito/PEP_CLIENT/text())
            	return
            		if($PEP_CLIENT != "") then (  
            			<AZXGCI-USER-8>{ $PEP_CLIENT }</AZXGCI-USER-8>
            		) else (<AZXGCI-USER-8 xsi:nil="true" />)	
            }
            <AZXGCI-USER-9  xsi:nil="true" />
            { 
            	let $expirationDate := string($actualizacionClienteTarjetaCredito/EXPIRATION_DATE_CLIENT_ID/text())
            	return
            		if($expirationDate != "") then(
            			<AZXGCI-USER-10>{ fn-bea:date-to-string-with-format('yyyyDDD', xs:date($expirationDate))} </AZXGCI-USER-10>
            		)else(<AZXGCI-USER-10 xsi:nil="true" />) 
            }
            { 
            	let $issueDate := string($actualizacionClienteTarjetaCredito/ISSUE_DATE_CLIENT_ID/text())
            	return
            		if($issueDate != "") then(
            			<AZXGCI-USER-11>{ fn-bea:date-to-string-with-format('yyyyDDD', xs:date($issueDate)) }</AZXGCI-USER-11>
            		)else(<AZXGCI-USER-11 xsi:nil="true" />) 
            }
                        
            { 
            	let $PROFESSION_DESC := data($actualizacionClienteTarjetaCredito/PROFESSION_DESC)
            	return
            		if($PROFESSION_DESC != "") then(
            			  <AZXGCI-USER-12>{ $PROFESSION_DESC }</AZXGCI-USER-12>
            		)else(<AZXGCI-USER-12 xsi:nil="true" />) 
            }          
            { 
            	let $CITY_OF_BIRTH := string($actualizacionClienteTarjetaCredito/CITY_OF_BIRTH/text())
            	return
            		if($CITY_OF_BIRTH != "") then(
            			<AZXGCI-USER-13>{ $CITY_OF_BIRTH }</AZXGCI-USER-13>
            		)else(<AZXGCI-USER-13 xsi:nil="true" />) 
            }
            
            { 
            	let $EDUCATION_LEVEL := string($actualizacionClienteTarjetaCredito/EDUCATION_LEVEL/text())
            	return
            		if($EDUCATION_LEVEL != "") then(
            			<AZXGCI-USER-14>{ $EDUCATION_LEVEL }</AZXGCI-USER-14>
            		)else(<AZXGCI-USER-14 xsi:nil="true" />) 
            }
            
            {
            	let $MONTHLY_INCOME := fn:string($actualizacionClienteTarjetaCredito/MONTHLY_INCOME/text())
            	return
            		if($MONTHLY_INCOME != "")then( 
            			<AZXGCI-USER-15>{ $MONTHLY_INCOME }</AZXGCI-USER-15>
        			)else(
        				<AZXGCI-USER-15 xsi:nil="true"/>
        			)
            }           
            <AZXGCI-USER-DEMO-1  xsi:nil="true" />
            <AZXGCI-USER-DEMO-2  xsi:nil="true" />
            (:Tokenización del valor de FREQUENT_FLYEER usando el delimitador | para LM:)
            {
    			let $FREQUENT_FLYEER := data($actualizacionClienteTarjetaCredito/FREQUENT_FLYEER/text())
    			let $tokens := fn:tokenize($FREQUENT_FLYEER, "\|")
    			return (
        			if (count($tokens) > 0 and fn:string-length($tokens[1]) > 0) then (
            			<AZXGCI-USER-DEMO-3>{ $tokens[1] }</AZXGCI-USER-DEMO-3>
        			) else (
        				<AZXGCI-USER-DEMO-3 xsi:nil="true"/>
        			)
    			)
			}
			(: Funcionalidad para Viajero Frecuente :)
            <AZXGCI-1099C-FOREIGN-IND  xsi:nil="true" />
            <AZXGCI-CR-1-2  xsi:nil="true" />
            <AZXGCI-CR-3-4  xsi:nil="true" />
            <AZXGCI-1099C-W9-DATE-SENT  xsi:nil="true" />
            <AZXGCI-STMT-MSG-INDIC  xsi:nil="true" />
            (:Tokenización del valor de FREQUENT_FLYEER usando el delimitador | para AA:)
            {
    			let $FREQUENT_FLYEER := data($actualizacionClienteTarjetaCredito/FREQUENT_FLYEER/text())
    			let $tokens := fn:tokenize($FREQUENT_FLYEER, "\|")
    			return (
        			if (count($tokens) > 1 and fn:string-length($tokens[2]) > 0) then (
            			<AZXGCI-FF-NUMBER>{ $tokens[2] }</AZXGCI-FF-NUMBER>
        			) else (
            			<AZXGCI-FF-NUMBER xsi:nil="true"/>
        			)
    			)
			}
			(: Funcionalidad para Viajero Frecuente :)
            <AZXGCI-STMT-MSG-2-INDIC  xsi:nil="true" />
            <AZXGCI-ADDR-2-INDIC  xsi:nil="true" />
            <AZXGCI-ADDR-3-INDIC  xsi:nil="true" />
            <AZXGCI-ADDR-2-LINE-1  xsi:nil="true" />
            <AZXGCI-ADDR-2-LINE-2  xsi:nil="true" />
            <AZXGCI-ADDR-2-LINE-3  xsi:nil="true" />
            <AZXGCI-CITY-2  xsi:nil="true" />
            <AZXGCI-PSTL-CD-2  xsi:nil="true" />
            <AZXGCI-CNTRY-CD-2  xsi:nil="true" />
            <AZXGCI-ADDR-3-LINE-1  xsi:nil="true" />
            <AZXGCI-ADDR-3-LINE-2  xsi:nil="true" />
            <AZXGCI-ADDR-3-LINE-3  xsi:nil="true" />
            <AZXGCI-CITY-3  xsi:nil="true" />
            <AZXGCI-PSTL-CD-3  xsi:nil="true" />
            <AZXGCI-CNTRY-CD-3  xsi:nil="true" />
            <AZXGCI-USER-DATE-3  xsi:nil="true" />
            <AZXGCI-INCOME  xsi:nil="true" />
            <AZXGCI-CUIT  xsi:nil="true" />
            <AZXGCI-OCCUP-CODE  xsi:nil="true" />
            <AZXGCI-IVA-POSITION  xsi:nil="true" />
        </ns0:CustomerUpdateL8V2Request>
};

declare variable $actualizacionClienteTarjetaCredito as element(ns1:actualizacionClienteTarjetaCredito) external;
declare variable $ptEquivalencias as element() external;
xf:customerUpdateIn($actualizacionClienteTarjetaCredito,$ptEquivalencias)