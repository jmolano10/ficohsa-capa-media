(:: pragma bea:global-element-parameter parameter="$actualizacionClienteTarjetaCredito1" element="ns1:actualizacionClienteTarjetaCredito" location="../xsd/actualizacionClienteTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CustomerUpdateL8V2Request" location="../../../../v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$ptEquivalencias" type="ns2:TEQUIVALENCIA_CATALOGO" location="../../../../v2/BusinessServices/MDW/consultaEquivalenciasCatalogos/xsd/consultaEquivalenciasCatalogos_sp.xsd" ::)


declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizacionClienteTarjetaCreditoTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ActualizacionClienteTarjetaCredito/xq/CustomerUpdateL8V2/";
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

declare function xf:CustomerUpdateL8V2($actualizacionClienteTarjetaCredito1 as element(ns1:actualizacionClienteTarjetaCredito),
	$ptEquivalencias as element())
    as element(ns0:CustomerUpdateL8V2Request) {
        <ns0:CustomerUpdateL8V2Request>
            <AZXGCI-ORG>{ data($actualizacionClienteTarjetaCredito1/ORG) }</AZXGCI-ORG>
            <AZXGCI-CARD-NBR>{ fn-bea:pad-left(data($actualizacionClienteTarjetaCredito1/PRODUCT_NUMBER), 19, '0')  }</AZXGCI-CARD-NBR>
            <AZXGCI-NBR-TYPE>{ data($actualizacionClienteTarjetaCredito1/PRODUCT_TYPE) }</AZXGCI-NBR-TYPE>
            <AZXGCI-FOREIGN-USE>{ data($actualizacionClienteTarjetaCredito1/FOREIGN_INDICATOR) }</AZXGCI-FOREIGN-USE>
            <AZXGCI-DEMOGRAPHIC-DATAIND>{ data($actualizacionClienteTarjetaCredito1/DEMOGRAPHIC_DATA_INDICATOR) }</AZXGCI-DEMOGRAPHIC-DATAIND>
            <AZXGCI-USER-DATA-IND>{ data($actualizacionClienteTarjetaCredito1/USER_DATA_INDICATOR) }</AZXGCI-USER-DATA-IND>
            <AZXGCI-VIP-STATUS>{ data($actualizacionClienteTarjetaCredito1/VIP_STATUS) }</AZXGCI-VIP-STATUS>
            <AZXGCI-STATUS>{ data($actualizacionClienteTarjetaCredito1/CUSTOMER_STATUS) }</AZXGCI-STATUS>
            <AZXGCI-SIC-CODE xsi:nil="true"/>
            <AZXGCI-TITLE xsi:nil="true"/>
            {
            	let $MARITAL_STATUS := string($actualizacionClienteTarjetaCredito1/MARITAL_STATUS/text())
            	return
            		if($MARITAL_STATUS != "") then (  
            			<AZXGCI-MARITAL-STATUS>{ valorCatalogoOSBToAPP($MARITAL_STATUS, 'VISION+PA', '2', $ptEquivalencias) }</AZXGCI-MARITAL-STATUS>
            		) else (
            			<AZXGCI-MARITAL-STATUS xsi:nil="true"/>
            		)	
            }
            {
				let $NAME_1 := string($actualizacionClienteTarjetaCredito1/NAME_1/text())
            	return
            		if($NAME_1 != "") then (  
            			<AZXGCI-NAME-LINE-1>{ $NAME_1 }</AZXGCI-NAME-LINE-1>
            		) else (
            			<AZXGCI-NAME-LINE-1 xsi:nil="true"/>
            		)           
            }
            {
            	let $TYPE_NAME_1 := string($actualizacionClienteTarjetaCredito1/TYPE_NAME_1/text())
            	return(
            		if($TYPE_NAME_1 != "") then (  
            			<AZXGCI-NAME-LINE-1-TYP>{ data($TYPE_NAME_1) }</AZXGCI-NAME-LINE-1-TYP>
            		) else (
            			<AZXGCI-NAME-LINE-1-TYP xsi:nil="true"/>
            		)
            	)
            }
            {
				let $NAME_2 := string($actualizacionClienteTarjetaCredito1/NAME_2/text())
            	return
            		if($NAME_2 != "") then (  
            			<AZXGCI-NAME-LINE-2>{ $NAME_2 }</AZXGCI-NAME-LINE-2>
            		) else (
            			<AZXGCI-NAME-LINE-2 xsi:nil="true"/>
            		)           
            }
            {
            	let $TYPE_NAME_2 := string($actualizacionClienteTarjetaCredito1/TYPE_NAME_2/text())
            	return(
            		if($TYPE_NAME_2 != "") then (  
            			<AZXGCI-NAME-LINE-2-TYP>{ data($TYPE_NAME_2) }</AZXGCI-NAME-LINE-2-TYP>
            		) else (
            			<AZXGCI-NAME-LINE-2-TYP xsi:nil="true"/>
            		)
            	)
            }
            {
				let $NAME_3 := string($actualizacionClienteTarjetaCredito1/NAME_3/text())
            	return
            		if($NAME_3 != "") then (  
            			<AZXGCI-NAME-LINE-3>{ $NAME_3 }</AZXGCI-NAME-LINE-3>
            		) else (
            			<AZXGCI-NAME-LINE-3 xsi:nil="true"/>
            		)           
            }
            {
            	let $TYPE_NAME_3 := string($actualizacionClienteTarjetaCredito1/TYPE_NAME_3/text())
            	return(
            		if($TYPE_NAME_3 != "") then (  
            			<AZXGCI-NAME-LINE-3-TYP>{ data($TYPE_NAME_3) }</AZXGCI-NAME-LINE-3-TYP>
            		) else (
            			<AZXGCI-NAME-LINE-3-TYP xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $HOUSE_NUMBER := string($actualizacionClienteTarjetaCredito1/HOUSE_NUMBER/text())
            	return(
            		if($HOUSE_NUMBER != "") then (  
            			<AZXGCI-HOUSE-NBR>{ $HOUSE_NUMBER }</AZXGCI-HOUSE-NBR>
            		) else (
            			<AZXGCI-HOUSE-NBR xsi:nil="true"/>
            		)
            	)
            }            
            {
            	let $HOUSE_NAME := string($actualizacionClienteTarjetaCredito1/HOUSE_NAME/text())
            	return(
            		if($HOUSE_NAME != "") then (  
            			<AZXGCI-HOUSE-NAME>{ $HOUSE_NAME }</AZXGCI-HOUSE-NAME>
            		) else (
            			<AZXGCI-HOUSE-NAME xsi:nil="true"/>
            		)
            	)
            }   
            {
            	let $HOME_ADDRESS_LINE_1 := string($actualizacionClienteTarjetaCredito1/HOME_ADDRESS/HOME_ADDRESS_LINE_1/text())
            	return(
            		if($HOME_ADDRESS_LINE_1 != "") then (  
            			<AZXGCI-ADDR-1>{ $HOME_ADDRESS_LINE_1 }</AZXGCI-ADDR-1>
            		) else (
            			<AZXGCI-ADDR-1 xsi:nil="true"/>
            		)
            	)
            }  
            {
            	let $HOME_ADDRESS_LINE_2 := string($actualizacionClienteTarjetaCredito1/HOME_ADDRESS/HOME_ADDRESS_LINE_2/text())
            	return(
            		if($HOME_ADDRESS_LINE_2 != "") then (  
            			<AZXGCI-ADDR-2>{ $HOME_ADDRESS_LINE_2 }</AZXGCI-ADDR-2>
            		) else (
            			<AZXGCI-ADDR-2 xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $HOME_ADDRESS_LINE_3 := string($actualizacionClienteTarjetaCredito1/HOME_ADDRESS/HOME_ADDRESS_LINE_3/text())
            	return(
            		if($HOME_ADDRESS_LINE_3 != "") then (  
            			<AZXGCI-ADDR-3>{ $HOME_ADDRESS_LINE_3 }</AZXGCI-ADDR-3>
            		) else (
            			<AZXGCI-ADDR-3 xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $HOME_ADDRESS_LINE_4 := string($actualizacionClienteTarjetaCredito1/HOME_ADDRESS/HOME_ADDRESS_LINE_4/text())
            	return(
            		if($HOME_ADDRESS_LINE_4 != "") then (  
            			<AZXGCI-ADDR-4>{ $HOME_ADDRESS_LINE_4 }</AZXGCI-ADDR-4>
            		) else (
            			<AZXGCI-ADDR-4 xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $CITY := string($actualizacionClienteTarjetaCredito1/CITY/text())
            	return(
            		if($CITY != "") then (  
            			<AZXGCI-CITY>{ valorCatalogoOSBToAPP($CITY, 'VISION+PA', '8', $ptEquivalencias) }</AZXGCI-CITY>
            		) else (
            			<AZXGCI-CITY xsi:nil="true"/>
            		)
            	)
            }        
            {
            	let $STATE := string($actualizacionClienteTarjetaCredito1/STATE/text())
            	return(
            		if($STATE != "") then (  
            			<AZXGCI-STATE>{ $STATE }</AZXGCI-STATE>
            		) else (
            			<AZXGCI-STATE xsi:nil="true"/>
            		)
            	)
            } 
            {
            	let $ZIP_CODE := string($actualizacionClienteTarjetaCredito1/ZIP_CODE/text())
            	return(
            		if($ZIP_CODE != "") then (  
            			<AZXGCI-PSTL-CD>{ valorCatalogoOSBToAPP($ZIP_CODE, 'VISION+PA', '7', $ptEquivalencias) }</AZXGCI-PSTL-CD>
            		) else (
            			<AZXGCI-PSTL-CD xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $COUNTRY_OF_RESIDENCE := string($actualizacionClienteTarjetaCredito1/COUNTRY_OF_RESIDENCE/text())
            	return(
            		if($COUNTRY_OF_RESIDENCE != "") then (  
            			<AZXGCI-CNTRY-CD>{ $COUNTRY_OF_RESIDENCE }</AZXGCI-CNTRY-CD>
            		) else (
            			<AZXGCI-CNTRY-CD xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $RESIDENCE_TYPE := string($actualizacionClienteTarjetaCredito1/RESIDENCE_TYPE/text())
            	return(
            		if($RESIDENCE_TYPE != "") then (  
            			<AZXGCI-OWN-RENT-RESID-FLAG>{ data($RESIDENCE_TYPE) }</AZXGCI-OWN-RENT-RESID-FLAG>
            		) else (
            			<AZXGCI-OWN-RENT-RESID-FLAG xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $LANGUAGE := string($actualizacionClienteTarjetaCredito1/LANGUAGE/text())
            	return(
            		if($LANGUAGE != "") then (  
            			<AZXGCI-LANGUAGE-IND>{ $LANGUAGE }</AZXGCI-LANGUAGE-IND>
            		) else (
            			<AZXGCI-LANGUAGE-IND xsi:nil="true"/>
            		)
            	)
            }
            (:Validacion para campo MAILING-LIST:)
        	{
        		let $MAILING_LIST := fn:string($actualizacionClienteTarjetaCredito1/MAILING_LIST/text())
        		return
        			if($MAILING_LIST != "") then(
        				<AZXGCI-MAILING-LIST>{ data($MAILING_LIST) }</AZXGCI-MAILING-LIST>		
        			)else(
        				<AZXGCI-MAILING-LIST>E</AZXGCI-MAILING-LIST>
        			)
        	}
        	(:Validacion para campo MAILING-LIST:)
            {
            	let $CONTACT_INDICATOR := string($actualizacionClienteTarjetaCredito1/CONTACT_INDICATOR/text())
            	return(
            		if($CONTACT_INDICATOR != "") then (  
            			<AZXGCI-CONTACT-IND>{ data($CONTACT_INDICATOR) }</AZXGCI-CONTACT-IND>
            		) else (
            			<AZXGCI-CONTACT-IND xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $GENDER := string($actualizacionClienteTarjetaCredito1/GENDER/text())
            	return(
            		if($GENDER != "") then (  
            			<AZXGCI-GENDER-CODE>{ valorCatalogoOSBToAPP($GENDER, 'VISION+PA', '1', $ptEquivalencias) }</AZXGCI-GENDER-CODE>
            		) else (
            			<AZXGCI-GENDER-CODE xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $HOME_PHONE_NUMBER := string($actualizacionClienteTarjetaCredito1/HOME_PHONE_NUMBER/text())
            	return(
            		if($HOME_PHONE_NUMBER != "") then (  
            			<AZXGCI-HOME-PHONE>{ data($HOME_PHONE_NUMBER) }</AZXGCI-HOME-PHONE>
            		) else (
            			<AZXGCI-HOME-PHONE xsi:nil="true"/>
            		)
            	)
            }
            <AZXGCI-HOME-PHONE-IND xsi:nil="true"/>
            {
            	let $FAX_PHONE := string($actualizacionClienteTarjetaCredito1/FAX_PHONE/text())
            	return(
            		if($FAX_PHONE != "") then (  
            			<AZXGCI-FAX-PHONE>{ data($FAX_PHONE) }</AZXGCI-FAX-PHONE>
            		) else (
            			<AZXGCI-FAX-PHONE xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $PHONE_INDICATOR := string($actualizacionClienteTarjetaCredito1/PHONE_INDICATOR/text())
            	return(
            		if($PHONE_INDICATOR != "") then (  
            			<AZXGCI-FAX-PHONE-IND>{ data($PHONE_INDICATOR) }</AZXGCI-FAX-PHONE-IND>
            		) else (
            			<AZXGCI-FAX-PHONE-IND xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $MOBILE_PHONE := string($actualizacionClienteTarjetaCredito1/MOBILE_PHONE/text())
            	return(
            		if($MOBILE_PHONE != "") then (  
            			<AZXGCI-MOBILE-PHONE>{ data($MOBILE_PHONE) }</AZXGCI-MOBILE-PHONE>
            		) else (
            			<AZXGCI-MOBILE-PHONE xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $MOBILE_INDICATOR := string($actualizacionClienteTarjetaCredito1/MOBILE_INDICATOR/text())
            	return(
            		if($MOBILE_INDICATOR != "") then (  
            			<AZXGCI-MOBILE-PHONE-IND>{ data($MOBILE_INDICATOR) }</AZXGCI-MOBILE-PHONE-IND>
            		) else (
            			<AZXGCI-MOBILE-PHONE-IND xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $BIRTH_DATE := string($actualizacionClienteTarjetaCredito1/BIRTH_DATE/text())
            	return(
            		if($BIRTH_DATE != "") then (  
            			<AZXGCI-DOB>{data($BIRTH_DATE)}</AZXGCI-DOB>
            		) else (
            			<AZXGCI-DOB xsi:nil="true"/>
            		)
            	)
            }
           	{
            	let $COUNTRY_OF_ISSUE_DOC2 := string($actualizacionClienteTarjetaCredito1/COUNTRY_OF_ISSUE_DOC2/text())
            	return(
            		if($COUNTRY_OF_ISSUE_DOC2 != "") then (  
            			<AZXGCI-DL-CNTRY>{ data($COUNTRY_OF_ISSUE_DOC2) }</AZXGCI-DL-CNTRY>
            		) else (
            			<AZXGCI-DL-CNTRY xsi:nil="true"/>
            		)
            	)
            }           
            <AZXGCI-DL-STATE xsi:nil="true"/>
            {
            	let $DRIVERS_LICENSE := string($actualizacionClienteTarjetaCredito1/DRIVERS_LICENSE/text())
            	return(
            		if($DRIVERS_LICENSE != "") then (  
            			<AZXGCI-DL-NBR>{ data($DRIVERS_LICENSE) }</AZXGCI-DL-NBR>
            		) else (
            			<AZXGCI-DL-NBR xsi:nil="true"/>
            		)
            	)
            }
           	{
            	let $DOCUMENT_TYPE_1 := string($actualizacionClienteTarjetaCredito1/DOCUMENT_TYPE_1/text())
            	return(
            		if($DOCUMENT_TYPE_1 != "") then (  
            			<AZXGCI-TAX-ID-TYP>{ valorCatalogoOSBToAPP($DOCUMENT_TYPE_1, 'VISION+PA', '4', $ptEquivalencias) }</AZXGCI-TAX-ID-TYP>
            		) else (
            			<AZXGCI-TAX-ID-TYP xsi:nil="true"/>
            		)
            	)
            }          
            {
            	let $DOCUMENT_ID_1 := string($actualizacionClienteTarjetaCredito1/DOCUMENT_ID_1/text())
            	return(
            		if($DOCUMENT_ID_1 != "") then (  
            			<AZXGCI-TAX-ID>{ data($DOCUMENT_ID_1) }</AZXGCI-TAX-ID>
            		) else (
            			<AZXGCI-TAX-ID xsi:nil="true"/>
            		)
            	)
            }
            <AZXGCI-1099C-W9-DATE-FILED xsi:nil="true"/>
            {
            	let $WORKPLACE := string($actualizacionClienteTarjetaCredito1/WORKPLACE/text())
            	return(
            		if($WORKPLACE != "") then (  
            			<AZXGCI-EMPLOYER>{ data($WORKPLACE) }</AZXGCI-EMPLOYER>
            		) else (
            			<AZXGCI-EMPLOYER xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $WORK_ADDRESS_1 := string($actualizacionClienteTarjetaCredito1/WORK_ADDRESS/WORK_ADDRESS_1/text())
            	return(
            		if($WORK_ADDRESS_1 != "") then (  
            			<AZXGCI-EMPLOYER-ADDR-1>{ data($WORK_ADDRESS_1) }</AZXGCI-EMPLOYER-ADDR-1>
            		) else (
            			<AZXGCI-EMPLOYER-ADDR-1 xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $WORK_ADDRESS_2 := string($actualizacionClienteTarjetaCredito1/WORK_ADDRESS/WORK_ADDRESS_2/text())
            	return(
            		if($WORK_ADDRESS_2 != "") then (  
            			<AZXGCI-EMPLOYER-ADDR-2>{ data($WORK_ADDRESS_2) }</AZXGCI-EMPLOYER-ADDR-2>
            		) else (
            			<AZXGCI-EMPLOYER-ADDR-2 xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $WORK_PHONE_NUMBER := string($actualizacionClienteTarjetaCredito1/WORK_PHONE_NUMBER/text())
            	return(
            		if($WORK_PHONE_NUMBER != "") then (  
            			<AZXGCI-EMP-PHONE>{ data($WORK_PHONE_NUMBER) }</AZXGCI-EMP-PHONE>
            		) else (
            			<AZXGCI-EMP-PHONE xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $WORK_EXTENSION := string($actualizacionClienteTarjetaCredito1/WORK_EXTENSION/text())
            	return(
            		if($WORK_EXTENSION != "") then (  
            			<AZXGCI-EMP-PHONE-EXTN>{ data($WORK_EXTENSION) }</AZXGCI-EMP-PHONE-EXTN>
            		) else (
            			<AZXGCI-EMP-PHONE-EXTN xsi:nil="true"/>
            		)
            	)
            }
            <AZXGCI-EMP-PHONE-FLAG xsi:nil="true"/>
            {
            	let $PROFESSION := string($actualizacionClienteTarjetaCredito1/PROFESSION/text())
            	return(
            		if($PROFESSION != "") then (  
            			<AZXGCI-POSITION>{ valorCatalogoOSBToAPP($PROFESSION, 'VISION+PA', '3', $ptEquivalencias) }</AZXGCI-POSITION>
            		) else (
            			<AZXGCI-POSITION xsi:nil="true"/>
            		)
            	)
            }
          	{
            	let $RELATIVE_NAME := string($actualizacionClienteTarjetaCredito1/RELATIVE_NAME/text())
            	return(
            		if($RELATIVE_NAME != "") then (  
            			<AZXGCI-RELATIVE-NAME>{ data($RELATIVE_NAME) }</AZXGCI-RELATIVE-NAME>
            		) else (
            			<AZXGCI-RELATIVE-NAME xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $DEPENDENTS := string($actualizacionClienteTarjetaCredito1/DEPENDENTS/text())
            	return(
            		if($DEPENDENTS != "") then (  
            			<AZXGCI-NBR-OF-DEPENDENTS>{ data($DEPENDENTS) }</AZXGCI-NBR-OF-DEPENDENTS>
            		) else (
            			<AZXGCI-NBR-OF-DEPENDENTS xsi:nil="true"/>
            		)
            	)
            }     
            {
                for $EMAIL in $actualizacionClienteTarjetaCredito1/EMAIL
                return
                    <AZXGCI-EMAIL>{ data($EMAIL) }</AZXGCI-EMAIL>
            }     
            <AZXGCI-EMAIL-IND xsi:nil="true"/>
            <AZXGCI-SMS-IND xsi:nil="true"/>
            {
            	let $NAMES := string($actualizacionClienteTarjetaCredito1/NAMES/text())
            	return(
            		if($NAMES != "") then (  
            			<AZXGCI-FIRST-NAME>{ data($NAMES) }</AZXGCI-FIRST-NAME>
            		) else (
            			<AZXGCI-FIRST-NAME xsi:nil="true"/>
            		)
            	)
            }    
            <AZXGCI-MIDDLE-NAME xsi:nil="true"/>
            {
            	let $LAST_NAMES := string($actualizacionClienteTarjetaCredito1/LAST_NAMES/text())
            	return(
            		if($LAST_NAMES != "") then (  
            			<AZXGCI-LAST-NAME>{ data($LAST_NAMES) }</AZXGCI-LAST-NAME>
            		) else (
            			<AZXGCI-LAST-NAME xsi:nil="true"/>
            		)
            	)
            }           
            <AZXGCI-SUFFIX xsi:nil="true"/>
            {
            	let $BIRTH_COUNTRY := string($actualizacionClienteTarjetaCredito1/BIRTH_COUNTRY/text())
            	return(
            		if($BIRTH_COUNTRY != "") then (  
            			<AZXGCI-COUNTY>{ data($BIRTH_COUNTRY) }</AZXGCI-COUNTY>
            		) else (
            			<AZXGCI-COUNTY xsi:nil="true"/>
            		)
            	)
            }   
            {
            	let $CHANEL_CODE_1 := string($actualizacionClienteTarjetaCredito1/CHANEL_CODE/CHANEL_CODE_1/text())
            	return(
            		if($CHANEL_CODE_1 != "") then (  
            			<AZXGCI-MEMO-1>{ data($CHANEL_CODE_1) }</AZXGCI-MEMO-1>
            		) else (
            			<AZXGCI-MEMO-1 xsi:nil="true"/>
            		)
            	)
            }          
            {
            	let $CHANEL_CODE_2 := string($actualizacionClienteTarjetaCredito1/CHANEL_CODE/CHANEL_CODE_2/text())
            	return(
            		if($CHANEL_CODE_2 != "") then (  
            			<AZXGCI-MEMO-2>{ data($CHANEL_CODE_2) }</AZXGCI-MEMO-2>
            		) else (
            			<AZXGCI-MEMO-2 xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $EMPLOYMENT_YEARS := string($actualizacionClienteTarjetaCredito1/EMPLOYMENT_YEARS/text())
            	return(
            		if($EMPLOYMENT_YEARS != "") then (  
            			<AZXGCI-USER-1>{ data($EMPLOYMENT_YEARS) }</AZXGCI-USER-1>
            		) else (
            			<AZXGCI-USER-1 xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $EMPLOYMENT_MONTHS := string($actualizacionClienteTarjetaCredito1/EMPLOYMENT_MONTHS/text())
            	return(
            		if($EMPLOYMENT_MONTHS != "") then (  
            			<AZXGCI-USER-2>{ data($EMPLOYMENT_MONTHS) }</AZXGCI-USER-2>
            		) else (
            			<AZXGCI-USER-2 xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $WORK_TITLE := string($actualizacionClienteTarjetaCredito1/WORK_TITLE/text())
            	return(
            		if($WORK_TITLE != "") then (  
            			<AZXGCI-USER-3>{ data($WORK_TITLE) }</AZXGCI-USER-3>
            		) else (
            			<AZXGCI-USER-3 xsi:nil="true"/>
            		)
            	)
            }
            <AZXGCI-USER-4 xsi:nil="true"/>
            <AZXGCI-USER-5 xsi:nil="true"/>
            {
            	let $SEGMENT := string($actualizacionClienteTarjetaCredito1/SEGMENT/text())
            	return(
            		if($SEGMENT != "") then (  
            			<AZXGCI-USER-6>{ data($SEGMENT) }</AZXGCI-USER-6>
            		) else (
            			<AZXGCI-USER-6 xsi:nil="true"/>
            		)
            	)
            }
            <AZXGCI-USER-7 xsi:nil="true"/>
            {
            	let $PEP_CLIENT:= string($actualizacionClienteTarjetaCredito1/PEP_CLIENT/text())
            	return(
            		if($PEP_CLIENT != "") then (  
            			<AZXGCI-USER-8>{ data($PEP_CLIENT) }</AZXGCI-USER-8>
            		) else (
            			<AZXGCI-USER-8 xsi:nil="true"/>
            		)
            	)
            }                        
            <AZXGCI-USER-9 xsi:nil="true"/>
            {
            	let $EXPIRATION_DATE_1:= string($actualizacionClienteTarjetaCredito1/EXPIRATION_DATE_1/text())
            	return(
            		if($EXPIRATION_DATE_1 != "") then (  
            			<AZXGCI-USER-10>{ data($EXPIRATION_DATE_1) }</AZXGCI-USER-10>
            		) else (
            			<AZXGCI-USER-10 xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $ISSUE_DATE_1:= string($actualizacionClienteTarjetaCredito1/ISSUE_DATE_1/text())
            	return(
            		if($ISSUE_DATE_1 != "") then (  
            			<AZXGCI-USER-11>{ data($ISSUE_DATE_1) }</AZXGCI-USER-11>
            		) else (
            			<AZXGCI-USER-11 xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $COUNTRY_ISSUE_PASSPORT:= string($actualizacionClienteTarjetaCredito1/COUNTRY_ISSUE_PASSPORT/text())
            	return(
            		if($COUNTRY_ISSUE_PASSPORT != "") then (  
            			<AZXGCI-USER-12>{ data($COUNTRY_ISSUE_PASSPORT) }</AZXGCI-USER-12>
            		) else (
            			<AZXGCI-USER-12 xsi:nil="true"/>
            		)
            	)
            }         
            <AZXGCI-USER-13 xsi:nil="true"/>
            {
            	let $STUDY_GRADE:= string($actualizacionClienteTarjetaCredito1/STUDY_GRADE/text())
            	return(
            		if($STUDY_GRADE != "") then (  
            			<AZXGCI-USER-14>{ data($STUDY_GRADE) }</AZXGCI-USER-14>
            		) else (
            			<AZXGCI-USER-14 xsi:nil="true"/>
            		)
            	)
            } 
            {
            	let $INCOMES:= string($actualizacionClienteTarjetaCredito1/INCOMES/text())
            	return(
            		if($INCOMES != "") then (  
            			<AZXGCI-USER-15>{ data($INCOMES) }</AZXGCI-USER-15>
            		) else (
            			<AZXGCI-USER-15 xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $OTHERS_INCOMES:= string($actualizacionClienteTarjetaCredito1/OTHERS_INCOMES/text())
            	return(
            		if($OTHERS_INCOMES != "") then (  
            			<AZXGCI-USER-DEMO-1>{ data($OTHERS_INCOMES) }</AZXGCI-USER-DEMO-1>
            		) else (
            			<AZXGCI-USER-DEMO-1 xsi:nil="true"/>
            		)
            	)
            }
            {
            	let $NATIONALITY:= string($actualizacionClienteTarjetaCredito1/NATIONALITY/text())
            	return(
            		if($NATIONALITY != "") then (  
            			<AZXGCI-USER-DEMO-2>{ data($NATIONALITY) }</AZXGCI-USER-DEMO-2>
            		) else (
            			<AZXGCI-USER-DEMO-2 xsi:nil="true"/>
            		)
            	)
            }
            (:Tokenización del valor de FREQUENT_FLYEER usando el delimitador | para LM:)
            {
    			let $FREQUENT_FLYEER := data($actualizacionClienteTarjetaCredito1/FREQUENT_FLYEER/text())
    			let $tokens := fn:tokenize($FREQUENT_FLYEER, "\|")
    			return (
        			if (count($tokens) > 0 and fn:string-length($tokens[1]) > 0) then (
            			<AZXGCI-USER-DEMO-3>{ $tokens[1] }</AZXGCI-USER-DEMO-3>
        			) else (
        				<AZXGCI-USER-DEMO-3/>
        			)
    			)
			}
			(: Funcionalidad para Viajero Frecuente :)
            <AZXGCI-1099C-FOREIGN-IND xsi:nil="true"/>
            <AZXGCI-CR-1-2 xsi:nil="true"/>
            <AZXGCI-CR-3-4 xsi:nil="true"/>
            <AZXGCI-1099C-W9-DATE-SENT xsi:nil="true"/>
            <AZXGCI-STMT-MSG-INDIC xsi:nil="true"/>
            (:Tokenización del valor de FREQUENT_FLYEER usando el delimitador | para AA:)
            {
    			let $FREQUENT_FLYEER := data($actualizacionClienteTarjetaCredito1/FREQUENT_FLYEER/text())
    			let $tokens := fn:tokenize($FREQUENT_FLYEER, "\|")
    			return (
        			if (count($tokens) > 1 and fn:string-length($tokens[2]) > 0) then (
            			<AZXGCI-FF-NUMBER>{ $tokens[2] }</AZXGCI-FF-NUMBER>
        			) else (
            			<AZXGCI-FF-NUMBER/>
        			)
    			)
			}
			(: Funcionalidad para Viajero Frecuente :)
            {
            	for $STMT_MSG_2_INDIC in $actualizacionClienteTarjetaCredito1/STMT_MSG_2_INDIC
            	return
            	if(string($STMT_MSG_2_INDIC/text()) != "")then(
            		<AZXGCI-STMT-MSG-2-INDIC>{ data($STMT_MSG_2_INDIC) }</AZXGCI-STMT-MSG-2-INDIC>
            	)else(
            		<AZXGCI-STMT-MSG-2-INDIC xsi:nil="true"/>
            	)
            }
            {
            	for $WORK_ADDREES_2_INDICATOR in $actualizacionClienteTarjetaCredito1/WORK_ADDREES_2_INDICATOR
            	return
            	if(string($WORK_ADDREES_2_INDICATOR/text()) != "")then(
            		<AZXGCI-ADDR-2-INDIC>{ data($WORK_ADDREES_2_INDICATOR) }</AZXGCI-ADDR-2-INDIC>
            	)else(
            		<AZXGCI-ADDR-2-INDIC xsi:nil="true"/>
            	)
            }
            {
            	for $WORK_ADDREES_3_INDICATOR in $actualizacionClienteTarjetaCredito1/WORK_ADDREES_3_INDICATOR
            	return
            	if(string($WORK_ADDREES_3_INDICATOR/text()) != "")then(
            		<AZXGCI-ADDR-3-INDIC>{ data($WORK_ADDREES_3_INDICATOR) }</AZXGCI-ADDR-3-INDIC>
            	)else(
            		<AZXGCI-ADDR-3-INDIC xsi:nil="true"/>
            	)
            }
            {
            	for $WORK_ADRRESS_2_LINE_1 in $actualizacionClienteTarjetaCredito1/WORK_ADDRESS_2/WORK_ADRRESS_2_LINE_1
            	return
            	if(string($WORK_ADRRESS_2_LINE_1/text()) != "")then(
            		<AZXGCI-ADDR-2-LINE-1>{ data($WORK_ADRRESS_2_LINE_1) }</AZXGCI-ADDR-2-LINE-1>
            	)else(
            		<AZXGCI-ADDR-2-LINE-1 xsi:nil="true"/>
            	)
            }
            {
            	for $WORK_ADRRESS_2_LINE_2 in $actualizacionClienteTarjetaCredito1/WORK_ADDRESS_2/WORK_ADRRESS_2_LINE_2
            	return
            	if(string($WORK_ADRRESS_2_LINE_2/text()) != "")then(
            		<AZXGCI-ADDR-2-LINE-2>{ data($WORK_ADRRESS_2_LINE_2) }</AZXGCI-ADDR-2-LINE-2>
            	)else(
            		<AZXGCI-ADDR-2-LINE-2 xsi:nil="true"/>
            	)
            }
            {
            	for $WORK_ADDRESS_2_LINE_3 in $actualizacionClienteTarjetaCredito1/WORK_ADDRESS_2/WORK_ADDRESS_2_LINE_3
            	return
            	if(string($WORK_ADDRESS_2_LINE_3/text()) != "")then(
            		<AZXGCI-ADDR-2-LINE-3>{ data($WORK_ADDRESS_2_LINE_3) }</AZXGCI-ADDR-2-LINE-3>
            	)else(
            		<AZXGCI-ADDR-2-LINE-3 xsi:nil="true"/>
            	)
            }
            {
            	for $CITY-2 in $actualizacionClienteTarjetaCredito1/CITY-2
            	return
            	if(string($CITY-2/text()) != "")then(
            		<AZXGCI-CITY-2>{ valorCatalogoOSBToAPP($CITY-2, 'VISION+PA', '8', $ptEquivalencias) }</AZXGCI-CITY-2>
            	)else(
            		<AZXGCI-CITY-2 xsi:nil="true"/>
            	)
            }
            {
            	for $PSTL-CD-2 in $actualizacionClienteTarjetaCredito1/PSTL-CD-2
            	return
            	if(string($PSTL-CD-2/text()) != "")then(
            		<AZXGCI-PSTL-CD-2>{ valorCatalogoOSBToAPP($PSTL-CD-2, 'VISION+PA', '7', $ptEquivalencias) }</AZXGCI-PSTL-CD-2>
            	)else(
            		<AZXGCI-PSTL-CD-2 xsi:nil="true"/>
            	)
            }
            {
            	for $CNTRY-CD-2 in $actualizacionClienteTarjetaCredito1/CNTRY-CD-2
            	return
            	if(string($CNTRY-CD-2/text()) != "")then(
            		<AZXGCI-CNTRY-CD-2>{ data($CNTRY-CD-2) }</AZXGCI-CNTRY-CD-2>
            	)else(
            		<AZXGCI-CNTRY-CD-2 xsi:nil="true"/>
            	)
            }
            {
            	for $WORK_ADDRESS_3_LINE_1 in $actualizacionClienteTarjetaCredito1/WORK_ADDRESS_3/WORK_ADDRESS_3_LINE_1
            	return
            	if(string($WORK_ADDRESS_3_LINE_1/text()) != "")then(
            		<AZXGCI-ADDR-3-LINE-1>{ data($WORK_ADDRESS_3_LINE_1) }</AZXGCI-ADDR-3-LINE-1>
            	)else(
            		<AZXGCI-ADDR-3-LINE-1 xsi:nil="true"/>
            	)
            }
            {
            	for $WORK_ADDRESS_3_LINE_2 in $actualizacionClienteTarjetaCredito1/WORK_ADDRESS_3/WORK_ADDRESS_3_LINE_2
            	return
            	if(string($WORK_ADDRESS_3_LINE_2/text()) != "")then(
            		<AZXGCI-ADDR-3-LINE-2>{ data($WORK_ADDRESS_3_LINE_2) }</AZXGCI-ADDR-3-LINE-2>
            	)else(
            		<AZXGCI-ADDR-3-LINE-2 xsi:nil="true"/>
            	)
            }
            {
            	for $WORK_ADDRESS_3_LINE_3 in $actualizacionClienteTarjetaCredito1/WORK_ADDRESS_3/WORK_ADDRESS_3_LINE_3
            	return
            	if(string($WORK_ADDRESS_3_LINE_3/text()) != "")then(
            		<AZXGCI-ADDR-3-LINE-3>{ data($WORK_ADDRESS_3_LINE_3) }</AZXGCI-ADDR-3-LINE-3>
            	)else(
            		<AZXGCI-ADDR-3-LINE-3 xsi:nil="true"/>
            	)
            }
            {
            	for $ALTERNATE_CITY in $actualizacionClienteTarjetaCredito1/ALTERNATE_CITY
            	return
            	if(string($ALTERNATE_CITY/text()) != "")then(
            		<AZXGCI-CITY-3>{ valorCatalogoOSBToAPP($ALTERNATE_CITY, 'VISION+PA', '8', $ptEquivalencias) }</AZXGCI-CITY-3>
            	)else(
            		<AZXGCI-CITY-3 xsi:nil="true"/>
            	)
            }
            {
            	for $PSTL-CD-3 in $actualizacionClienteTarjetaCredito1/PSTL-CD-3
            	return
            	if(string($PSTL-CD-3/text()) != "")then(
            		<AZXGCI-PSTL-CD-3>{ valorCatalogoOSBToAPP($PSTL-CD-3, 'VISION+PA', '7', $ptEquivalencias) }</AZXGCI-PSTL-CD-3>
            	)else(
            		<AZXGCI-PSTL-CD-3 xsi:nil="true"/>
            	)
            }
            {
            	for $ALTERNATE_COUNTRY in $actualizacionClienteTarjetaCredito1/ALTERNATE_COUNTRY
            	return
            	if(string($ALTERNATE_COUNTRY/text()) != "")then(
            		<AZXGCI-CNTRY-CD-3>{ data($ALTERNATE_COUNTRY) }</AZXGCI-CNTRY-CD-3>
            	)else(
            		<AZXGCI-CNTRY-CD-3 xsi:nil="true"/>
            	)
            }
        	<AZXGCI-USER-DATE-3 xsi:nil="true"/>
        	<AZXGCI-INCOME xsi:nil="true"/>
        	<AZXGCI-CUIT xsi:nil="true"/>
        	<AZXGCI-OCCUP-CODE xsi:nil="true"/>
        	<AZXGCI-IVA-POSITION xsi:nil="true"/>
        </ns0:CustomerUpdateL8V2Request>
};

declare variable $actualizacionClienteTarjetaCredito1 as element(ns1:actualizacionClienteTarjetaCredito) external;
declare variable $ptEquivalencias as element() external;

xf:CustomerUpdateL8V2($actualizacionClienteTarjetaCredito1, $ptEquivalencias)