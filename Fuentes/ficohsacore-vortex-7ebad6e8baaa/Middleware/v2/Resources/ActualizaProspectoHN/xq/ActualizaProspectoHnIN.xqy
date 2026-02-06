xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$actualizaProspecto1" element="ns1:actualizaProspecto" location="../../ActualizaProspecto/xsd/actualizaProspectoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:UpdateProspect" location="../../../BusinessServices/T24/ActualizaProspecto/xsd/svcUpdateProspect_1.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizaProspectoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaProspectoHN/xq/ActualizaProspectoHnIN/";


(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:ActualizaProspectoHnIN($actualizaProspecto1 as element(ns1:actualizaProspecto),
    $accountOfficer as xs:string,
    $userName as xs:string,
    $password as xs:string)
    as element(ns0:UpdateProspect) {
        <ns0:UpdateProspect>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername($userName),$userName) }</userName>
                <password>{ fn-bea:fail-over( getPassword($userName),$password) }</password>
            </WebRequestCommon>
	         <OfsFunction>
	            <noOfAuth>0</noOfAuth>
	         </OfsFunction>            
             <CUSTOMERNEWPROSPECTVERSWSType id="{ data($actualizaProspecto1/ns1:BASIC_INFO/ns1:CUSTOMER_ID) }">
                <gSHORTNAME>
                    <ShortName>{ concat(data($actualizaProspecto1/ns1:BASIC_INFO/ns1:FIRST_NAME) , " ", data($actualizaProspecto1/ns1:BASIC_INFO/ns1:FIRST_LASTNAME)) }</ShortName>
                </gSHORTNAME>
                <gNAME1>
                    <FirstName>{ data($actualizaProspecto1/ns1:BASIC_INFO/ns1:FIRST_NAME) }</FirstName>
                </gNAME1>
                <gSTREET>
                    <StreetName>{ concat(data($actualizaProspecto1/ns1:CONTACT_INFO/ns1:ADDRESS_INFO/ns1:ADDRESS_ITEM[1]/ns1:ADDRESS_LINE_1) , " ", data($actualizaProspecto1/ns1:CONTACT_INFO/ns1:ADDRESS_INFO/ns1:ADDRESS_ITEM[1]/ns1:ADDRESS_LINE_2)) }</StreetName>
                </gSTREET>
                <Sector>{ data($actualizaProspecto1/ns1:BASIC_INFO/ns1:SECTOR) }</Sector>
                <AccountOfficer>{ $accountOfficer }</AccountOfficer>
                {
                    for $INDUSTRY in $actualizaProspecto1/ns1:BASIC_INFO/ns1:INDUSTRY
                    return
                        <Industry>{ data($INDUSTRY) }</Industry>
                }
                {
                    for $TARGET in $actualizaProspecto1/ns1:BASIC_INFO/ns1:TARGET
                    return
                        <Target>{ data($TARGET) }</Target>
                }
                <Nationality>{ data($actualizaProspecto1/ns1:BASIC_INFO/ns1:NATIONALITY) }</Nationality>
                <CustomerStatus>2</CustomerStatus>                
                <Residence>{ data($actualizaProspecto1/ns1:BASIC_INFO/ns1:COUNTRY_OF_RESIDENCE) }</Residence>
                <gLEGALID>
                	<mLEGALID>
                		<LEGALID>{ data($actualizaProspecto1/ns1:BASIC_INFO/ns1:IDENTIFICATION/ns1:LEGAL_IDENTIFICATION_ITEM[1]/ns1:LEGAL_ID) }</LEGALID>
                		<LEGALDOCNAME>{ data($actualizaProspecto1/ns1:BASIC_INFO/ns1:IDENTIFICATION/ns1:LEGAL_IDENTIFICATION_ITEM[1]/ns1:LEGAL_DOCUMENT_NAME) }</LEGALDOCNAME>
                	</mLEGALID>
                </gLEGALID>
                <Language>{ data($actualizaProspecto1/ns1:BASIC_INFO/ns1:LANGUAGE) }</Language>
                {
                    let $SECOND_NAME := $actualizaProspecto1/ns1:BASIC_INFO/ns1:SECOND_NAME/text()
                    let $THIRD_NAME := $actualizaProspecto1/ns1:BASIC_INFO/ns1:THIRD_NAME/text()
                    return
                    if (exists($SECOND_NAME) and exists($THIRD_NAME)) then (
						<Nombres>{ concat(data($actualizaProspecto1/ns1:BASIC_INFO/ns1:FIRST_NAME) , " ", $SECOND_NAME , " ", $THIRD_NAME) }</Nombres>
				    ) else if (exists($SECOND_NAME) and not(exists($THIRD_NAME))) then(
				    	<Nombres>{ concat(data($actualizaProspecto1/ns1:BASIC_INFO/ns1:FIRST_NAME) , " ", $SECOND_NAME) }</Nombres>
				    ) else if (not(exists($SECOND_NAME)) and not(exists($THIRD_NAME))) then(
				    	<Nombres>{ concat(data($actualizaProspecto1/ns1:BASIC_INFO/ns1:FIRST_NAME)) }</Nombres>
				    ) else ()
                }
                {
                    for $SECOND_LASTNAME in $actualizaProspecto1/ns1:BASIC_INFO/ns1:SECOND_LASTNAME
                    return
                        <Apellidos>{ concat(data($actualizaProspecto1/ns1:BASIC_INFO/ns1:FIRST_LASTNAME) , " ", $SECOND_LASTNAME) }</Apellidos>
                }
                <Gender>{ 
                if (data($actualizaProspecto1/ns1:BASIC_INFO/ns1:GENDER)= 'MALE') then (
                let $gender := "01"
                return  $gender
                ) else (
                let $gender := "02"
                return  $gender
                )
                }</Gender>
                <FECHANACIMIENTO>{ data($actualizaProspecto1/ns1:BASIC_INFO/ns1:DATE_OF_BIRTH) }</FECHANACIMIENTO>
                <MaritalStatus>{ data($actualizaProspecto1/ns1:BASIC_INFO/ns1:MARITAL_STATUS) }</MaritalStatus>
                <gPHONE1>
                    {
                        for $PHONE_NUMBER_ITEM in $actualizaProspecto1/ns1:CONTACT_INFO/ns1:PHONE_NUMBER_INFO/ns1:PHONE_NUMBER_ITEM[1]/ns1:PHONE_NUMBER                           
                        return
                            <PhoneNumber>{concat( data($actualizaProspecto1/ns1:CONTACT_INFO/ns1:PHONE_NUMBER_INFO/ns1:PHONE_NUMBER_ITEM[1]/ns1:PHONE_AREA_CODE),  data($PHONE_NUMBER_ITEM))}</PhoneNumber>
                    }
                </gPHONE1>
                <Ocupacion>{data($actualizaProspecto1/ns1:FINANCIAL_INFO/ns1:OCCUPATION)}</Ocupacion>
                <SRCOFINCOME>{data($actualizaProspecto1/ns1:FINANCIAL_INFO/ns1:SOURCE_OF_INCOME)}</SRCOFINCOME>
                <COLONYCODE>{data($actualizaProspecto1/ns1:CONTACT_INFO/ns1:ADDRESS_INFO/ns1:ADDRESS_ITEM[1]/ns1:COLONY_CODE)}</COLONYCODE>
            	<REFERENCES>{data($actualizaProspecto1/ns1:CONTACT_INFO/ns1:ADDRESS_INFO/ns1:ADDRESS_ITEM[1]/ns1:REFERENCES)}</REFERENCES>
            	<LRPEPLIST>{data($actualizaProspecto1/ns1:BASIC_INFO/ns1:PEP)}</LRPEPLIST>
            </CUSTOMERNEWPROSPECTVERSWSType>
        </ns0:UpdateProspect>
};

declare variable $actualizaProspecto1 as element(ns1:actualizaProspecto) external;
declare variable $accountOfficer as xs:string external;
declare variable $userName as xs:string external;
declare variable $password as xs:string external;

xf:ActualizaProspectoHnIN($actualizaProspecto1,
    $accountOfficer,
    $userName,
    $password)