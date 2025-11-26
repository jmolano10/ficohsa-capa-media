(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$actualizaSistemasT241" element="ns2:actualizaSistemasT24" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Actualizaciondeperfildecliente" location="../../../BusinessServices/T24/actualizacionPerfilT24/xsd/XMLSchema_-1279772603.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/operacionesDatosClientesTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizaciondeperfildeclienteIn/";

declare function getUsername ($username as xs:string)  as xs:string { 
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($username)))
		return
			$data/con:username/text()
};
declare function getPassword ($username as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($username)))
  		return
		   $data/con:password/text()
};

declare function xf:actualizaciondeperfildeclienteIn($requestHeader1 as element(ns0:RequestHeader),
    $actualizaSistemasT241 as element(ns2:actualizaSistemasT24))
    as element(ns1:Actualizaciondeperfildecliente) {
        <ns1:Actualizaciondeperfildecliente>
              <WebRequestCommon>
                <userName>
                  {
	                    fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)),
	                    	data($requestHeader1/Authentication/UserName))
	               }
                </userName>
                <password>
                  {
	                    fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
	                    	data($requestHeader1/Authentication/Password))
	              }
                </password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FICOBULKAPPRCLNTINPUTGFFWSType>
                <FIELDS1>{ string($actualizaSistemasT241/CUSTOMER_DATA/CUSTOMER_INFO/CUSTOMER_ID) }</FIELDS1>
                <FIELDS2>{ string($actualizaSistemasT241/CUSTOMER_DATA/CUSTOMER_INFO/MARITAL_STATUS) }</FIELDS2>
                <FIELDS3>{ string($actualizaSistemasT241/CUSTOMER_DATA/CUSTOMER_INFO/SPOUSE_NAME) }</FIELDS3>
                <FIELDS4>{ string($actualizaSistemasT241/CUSTOMER_DATA/CUSTOMER_INFO/CUSTOMER_SINCE) }</FIELDS4>
                <FIELDS5>{ string($actualizaSistemasT241/CUSTOMER_DATA/CUSTOMER_INFO/PROFESSION) }</FIELDS5>
                <FIELDS6>{ string($actualizaSistemasT241/CUSTOMER_DATA/CUSTOMER_INFO/JOB_TITLE) }</FIELDS6>
                <FIELDS7>{ string($actualizaSistemasT241/CUSTOMER_DATA/CUSTOMER_INFO/LINE_OF_BUSINESS) }</FIELDS7>
                <FIELDS8>{ string($actualizaSistemasT241/CUSTOMER_DATA/CUSTOMER_INFO/INCOME_RANGES) }</FIELDS8>
                <FIELDS9>{ string($actualizaSistemasT241/CUSTOMER_DATA/CONTROL_INFO/TICKET_NUMBER) }</FIELDS9>
                <FIELDS10>{ string($actualizaSistemasT241/CUSTOMER_DATA/CONTROL_INFO/CREATION_DATE) }</FIELDS10>
                <FIELDS11>{ string($actualizaSistemasT241/CUSTOMER_DATA/CONTROL_INFO/UPDATE_TIME) }</FIELDS11>
                <FIELDS12>{ string($actualizaSistemasT241/CUSTOMER_DATA/CONTROL_INFO/LAST_UPDATE) }</FIELDS12>
                <FIELDS13>{ string($actualizaSistemasT241/CUSTOMER_DATA/CONTROL_INFO/INTERFACE_USER) }</FIELDS13>
                <FIELDS14>{ string($actualizaSistemasT241/CUSTOMER_DATA/CONTROL_INFO/BRANCH_CODE) }</FIELDS14>
                <FIELDS15>{ string($actualizaSistemasT241/CUSTOMER_DATA/CONTROL_INFO/IP_ADDRESS) }</FIELDS15>
                <FIELDS16>{ string($actualizaSistemasT241/CUSTOMER_DATA/CONTROL_INFO/WORK_UNIT_AREA) }</FIELDS16>
                <FIELDS17>{ string($actualizaSistemasT241/CUSTOMER_DATA/SYSTEM_INFO/SOURCE) }</FIELDS17>
                <FIELDS18>{ string($actualizaSistemasT241/CUSTOMER_DATA/SYSTEM_INFO/STATUS) }</FIELDS18>
                <FIELDS19>{ string($actualizaSistemasT241/CUSTOMER_DATA/SYSTEM_INFO/COUNTRY) }</FIELDS19>
                <FIELDS20>{ string($actualizaSistemasT241/CUSTOMER_DATA/IDENTIFICATION_INFO/LEGAL_ID) }</FIELDS20>
                <FIELDS21>{ string($actualizaSistemasT241/CUSTOMER_DATA/IDENTIFICATION_INFO/LEGAL_DOCUMENT_NAME) }</FIELDS21>
                <FIELDS22>{ string($actualizaSistemasT241/CUSTOMER_DATA/IDENTIFICATION_INFO/ALTERNATE_ID) }</FIELDS22>
                <FIELDS23>{ string($actualizaSistemasT241/CUSTOMER_DATA/CUSTOMER_INFO/UUID) }</FIELDS23>
                <FIELDS24>{ string($actualizaSistemasT241/CUSTOMER_DATA/IDENTIFICATION_INFO/ALTERNATE_DOCUMENT_NAME) }</FIELDS24>
                <FIELDS25>{ string($actualizaSistemasT241/CUSTOMER_DATA/CONTROL_INFO/APPROVER_USER) }</FIELDS25>
                 <FIELDS26/>
                <FIELDS27/>
                <FIELDS28/>
                <FIELDS29/>
                <FIELDS30/>
                <FIELDS31/>
                <FIELDS32/>
                <FIELDS33/>
                <FIELDS34/>
                <FIELDS35/>
                <FIELDS36/>
                <FIELDS37/>
                <FIELDS38/>
                <FIELDS39/>
                <FIELDS40/>
                <FIELDS41/>
                <FIELDS42/>
                <FIELDS43/>
                <FIELDS44/>
                <FIELDS45/>
                <FIELDS46/>
                <FIELDS47/>
                <FIELDS48/>
                <FIELDS49/>
                <FIELDS50/>
                <FIELDS51/>
                <FIELDS52/>
                <FIELDS53/>
                <FIELDS54/>
                <FIELDS55/>
                <FIELDS56/>
                <FIELDS57/>
                <FIELDS58/>
                <FIELDS59/>
                <FIELDS60/>
                <FIELDS61/>
                <FIELDS62/>
                <FIELDS63/>
                <FIELDS64/>
                <FIELDS65/>
                <FIELDS66/>
                <FIELDS67/>
                <FIELDS68/>
                <FIELDS69/>
                <FIELDS70/>
                <FIELDS71/>
                <FIELDS72/>
                <FIELDS73/>
                <FIELDS74/>
                <FIELDS75/>
                <FIELDS76/>
                <FIELDS77/>
                <FIELDS78/>
                <FIELDS79/>
                <FIELDS80/>               
                <gFIELDS81>
                    <FIELDS81>{ data($actualizaSistemasT241/CUSTOMER_DATA/CUSTOMER_INFO/NATIONALITY) }</FIELDS81>
                </gFIELDS81>
                {
                	let $homeAddress := $actualizaSistemasT241/CUSTOMER_DATA/ADDRESS_INFO[fn:substring(TYPE,1,1) = '1']
                	let $workAddress :=  $actualizaSistemasT241/CUSTOMER_DATA/ADDRESS_INFO[fn:substring(TYPE,1,1) = '2']
                	let $otherAddress := $actualizaSistemasT241/CUSTOMER_DATA/ADDRESS_INFO[fn:substring(TYPE,1,1) = '3']
                	return
                     (
                     	<gFIELDS82>
                     	{
                     		if(not(empty($homeAddress))) then (
                     			<FIELDS82>{ data($homeAddress/TYPE)  }</FIELDS82>
                     		) else (
                     			<FIELDS82/>
                     		),
                     		if(not(empty($workAddress))) then (
                     			<FIELDS82>{ data($workAddress/TYPE)  }</FIELDS82>
                     		) else (
                     			<FIELDS82/>
                     		),
                     		if(not(empty($otherAddress))) then (
                     			<FIELDS82>{ data($otherAddress/TYPE)  }</FIELDS82>
                     		) else (
                     			<FIELDS82/>
                     		)
                     	}
                     	</gFIELDS82>,
                     	<gFIELDS83>
                     	{
                     		if(not(empty($homeAddress))) then (
                     			<FIELDS83>{ data($homeAddress/COUNTRY_CODE)  }</FIELDS83>
                     		) else (
                     			<FIELDS83/>
                     		),
                     		if(not(empty($workAddress))) then (
                     			<FIELDS83>{ data($workAddress/COUNTRY_CODE)  }</FIELDS83>
                     		) else (
                     			<FIELDS83/>
                     		),
                     		if(not(empty($otherAddress))) then (
                     			<FIELDS83>{ data($otherAddress/COUNTRY_CODE)  }</FIELDS83>
                     		) else (
                     			<FIELDS83/>
                     		)
                     	}
                     	</gFIELDS83>,
                     	<gFIELDS84>
                     	{
                     		if(not(empty($homeAddress))) then (
                     			<FIELDS84>{ data($homeAddress/STATE_CODE)  }</FIELDS84>
                     		) else (
                     			<FIELDS84/>
                     		),
                     		if(not(empty($workAddress))) then (
                     			<FIELDS84>{ data($workAddress/STATE_CODE)  }</FIELDS84>
                     		) else (
                     			<FIELDS84/>
                     		),
                     		if(not(empty($otherAddress))) then (
                     			<FIELDS84>{ data($otherAddress/STATE_CODE)  }</FIELDS84>
                     		) else (
                     			<FIELDS84/>
                     		)
                     	}
                     	</gFIELDS84>,
                     	<gFIELDS85>
                     	{
                     		if(not(empty($homeAddress))) then (
                     			<FIELDS85>{ data($homeAddress/CITY_CODE)  }</FIELDS85>
                     		) else (
                     			<FIELDS85/>
                     		),
                     		if(not(empty($workAddress))) then (
                     			<FIELDS85>{ data($workAddress/CITY_CODE)  }</FIELDS85>
                     		) else (
                     			<FIELDS85/>
                     		),
                     		if(not(empty($otherAddress))) then (
                     			<FIELDS85>{ data($otherAddress/CITY_CODE)  }</FIELDS85>
                     		) else (
                     			<FIELDS85/>
                     		)
                     	}
                     	</gFIELDS85>,
                     	<gFIELDS86>
                     	{
                     		if(not(empty($homeAddress))) then (
                     			<FIELDS86>{ data($homeAddress/COLONY_CODE)  }</FIELDS86>
                     		) else (
                     			<FIELDS86/>
                     		),
                     		if(not(empty($workAddress))) then (
                     			<FIELDS86>{ data($workAddress/COLONY_CODE)  }</FIELDS86>
                     		) else (
                     			<FIELDS86/>
                     		),
                     		if(not(empty($otherAddress))) then (
                     			<FIELDS86>{ data($otherAddress/COLONY_CODE)  }</FIELDS86>
                     		) else (
                     			<FIELDS86/>
                     		)
                     	}
                     	</gFIELDS86>,
                     	<gFIELDS87>
                     	{
                     		if(not(empty($homeAddress))) then (
                     			<FIELDS87>{ data($homeAddress/HOUSE_NUMBER)  }</FIELDS87>
                     		) else (
                     			<FIELDS87/>
                     		),
                     		if(not(empty($workAddress))) then (
                     			<FIELDS87>{ data($workAddress/HOUSE_NUMBER)  }</FIELDS87>
                     		) else (
                     			<FIELDS87/>
                     		),
                     		if(not(empty($otherAddress))) then (
                     			<FIELDS87>{ data($otherAddress/HOUSE_NUMBER)  }</FIELDS87>
                     		) else (
                     			<FIELDS87/>
                     		)
                     	}
                     	</gFIELDS87>,
                     	<gFIELDS88>
                     	{
                     		if(not(empty($homeAddress))) then (
                     			<FIELDS88>{ data($homeAddress/REFERENCES)  }</FIELDS88>
                     		) else (
                     			<FIELDS88/>
                     		),
                     		if(not(empty($workAddress))) then (
                     			<FIELDS88>{ data($workAddress/REFERENCES)  }</FIELDS88>
                     		) else (
                     			<FIELDS88/>
                     		),
                     		if(not(empty($otherAddress))) then (
                     			<FIELDS88>{ data($otherAddress/REFERENCES)  }</FIELDS88>
                     		) else (
                     			<FIELDS88/>
                     		)
                     	}
                     	</gFIELDS88>,
                     	<gFIELDS89>
                     	{
                     		if(not(empty($homeAddress))) then (
                     			<FIELDS89>{ data($homeAddress/STREET)  }</FIELDS89>
                     		) else (
                     			<FIELDS89/>
                     		),
                     		if(not(empty($workAddress))) then (
                     			<FIELDS89>{ data($workAddress/STREET)  }</FIELDS89>
                     		) else (
                     			<FIELDS89/>
                     		),
                     		if(not(empty($otherAddress))) then (
                     			<FIELDS89>{ data($otherAddress/STREET)  }</FIELDS89>
                     		) else (
                     			<FIELDS89/>
                     		)
                     	}
                     	</gFIELDS89>,
                     	<gFIELDS90>
                     	{
                     		if(not(empty($homeAddress))) then (
                     			<FIELDS90>{ data($homeAddress/AVENUE)  }</FIELDS90>
                     		) else (
                     			<FIELDS90/>
                     		),
                     		if(not(empty($workAddress))) then (
                     			<FIELDS90>{ data($workAddress/AVENUE)  }</FIELDS90>
                     		) else (
                     			<FIELDS90/>
                     		),
                     		if(not(empty($otherAddress))) then (
                     			<FIELDS90>{ data($otherAddress/AVENUE)  }</FIELDS90>
                     		) else (
                     			<FIELDS90/>
                     		)
                     	}
                     	</gFIELDS90>,
                     	<gFIELDS91>
                     	{
                     		if(not(empty($homeAddress))) then (
                     			<FIELDS91>{ data($homeAddress/BLOCK)  }</FIELDS91>
                     		) else (
                     			<FIELDS91/>
                     		),
                     		if(not(empty($workAddress))) then (
                     			<FIELDS91>{ data($workAddress/BLOCK)  }</FIELDS91>
                     		) else (
                     			<FIELDS91/>
                     		),
                     		if(not(empty($otherAddress))) then (
                     			<FIELDS91>{ data($otherAddress/BLOCK)  }</FIELDS91>
                     		) else (
                     			<FIELDS91/>
                     		)
                     	}
                     	</gFIELDS91>
                     )
                }
                <gFIELDS92/>
                <gFIELDS93/>
                <gFIELDS94/>
                {
                	let $homePhone:= $actualizaSistemasT241/CUSTOMER_DATA/PHONE_INFO[fn:substring(TYPE,1,1) = '1']
                	let $workPhone:= $actualizaSistemasT241/CUSTOMER_DATA/PHONE_INFO[fn:substring(TYPE,1,1) = '2']
                	let $otherPhone:= $actualizaSistemasT241/CUSTOMER_DATA/PHONE_INFO[fn:substring(TYPE,1,1) = '3']
                	return
                	     (
                     	<gFIELDS95>
                     	{
                     		if(not(empty($homePhone))) then (
                     			<FIELDS95>{ data($homePhone/TYPE)  }</FIELDS95>
                     		) else (
                     			<FIELDS95/>
                     		),
                     		if(not(empty($workPhone))) then (
                     			<FIELDS95>{ data($workPhone/TYPE)  }</FIELDS95>
                     		) else (
                     			<FIELDS95/>
                     		),
                     		if(not(empty($otherPhone))) then (
                     			<FIELDS95>{ data($otherPhone/TYPE)  }</FIELDS95>
                     		) else (
                     			<FIELDS95/>
                     		)
                     	}
                     	</gFIELDS95>,
                     	<gFIELDS96>
                     	{
                     		if(not(empty($homePhone))) then (
                     			<FIELDS96>{ data($homePhone/PHONE_NUMBER)  }</FIELDS96>
                     		) else (
                     			<FIELDS96/>
                     		),
                     		if(not(empty($workPhone))) then (
                     			<FIELDS96>{ data($workPhone/PHONE_NUMBER)  }</FIELDS96>
                     		) else (
                     			<FIELDS96/>
                     		),
                     		if(not(empty($otherPhone))) then (
                     			<FIELDS96>{ data($otherPhone/PHONE_NUMBER)  }</FIELDS96>
                     		) else (
                     			<FIELDS96/>
                     		)
                     	}
                     	</gFIELDS96>,
                     	<gFIELDS97>
                     	{
                     		if(not(empty($homePhone))) then (
                     			<FIELDS97>{ data($homePhone/EXTENSION)  }</FIELDS97>
                     		) else (
                     			<FIELDS97/>
                     		),
                     		if(not(empty($workPhone))) then (
                     			<FIELDS97>{ data($workPhone/EXTENSION)  }</FIELDS97>
                     		) else (
                     			<FIELDS97/>
                     		),
                     		if(not(empty($otherPhone))) then (
                     			<FIELDS97>{ data($otherPhone/EXTENSION)  }</FIELDS97>
                     		) else (
                     			<FIELDS97/>
                     		)
                     	}
                     	</gFIELDS97>
                	     
                	     )
                }
                {
                	let $homeEmail:= $actualizaSistemasT241/CUSTOMER_DATA/EMAIL_INFO[fn:substring(TYPE,1,1) = '1']
                	let $workEmail:= $actualizaSistemasT241/CUSTOMER_DATA/EMAIL_INFO[fn:substring(TYPE,1,1) = '2']
                	let $otherEmail:= $actualizaSistemasT241/CUSTOMER_DATA/EMAIL_INFO[fn:substring(TYPE,1,1) = '3']
                	return
                	     (
                     	<gFIELDS98>
                     	{
                     		if(not(empty($homeEmail))) then (
                     			<FIELDS98>{ data($homeEmail/TYPE)  }</FIELDS98>
                     		) else (
                     			<FIELDS98/>
                     		),
                     		if(not(empty($workEmail))) then (
                     			<FIELDS98>{ data($workEmail/TYPE)  }</FIELDS98>
                     		) else (
                     			<FIELDS98/>
                     		),
                     		if(not(empty($otherEmail))) then (
                     			<FIELDS98>{ data($otherEmail/TYPE)  }</FIELDS98>
                     		) else (
                     			<FIELDS98/>
                     		)
                     	}
                     	</gFIELDS98>,
                     	<gFIELDS99>
                     	{
                     		if(not(empty($homeEmail))) then (
                     			<FIELDS99>{ data($homeEmail/EMAIL)  }</FIELDS99>
                     		) else (
                     			<FIELDS99/>
                     		),
                     		if(not(empty($workEmail))) then (
                     			<FIELDS99>{ data($workEmail/EMAIL)  }</FIELDS99>
                     		) else (
                     			<FIELDS99/>
                     		),
                     		if(not(empty($otherEmail))) then (
                     			<FIELDS99>{ data($otherEmail/EMAIL)  }</FIELDS99>
                     		) else (
                     			<FIELDS99/>
                     		)
                     	}
                     	</gFIELDS99>
                	     )
                }
                <gFIELDS100>
                    <FIELDS100>{ data($actualizaSistemasT241/CUSTOMER_DATA/CUSTOMER_INFO/CELLULAR) }</FIELDS100>
                </gFIELDS100>
            </FICOBULKAPPRCLNTINPUTGFFWSType>
        </ns1:Actualizaciondeperfildecliente>
};

declare variable $requestHeader1 as element(ns0:RequestHeader) external;
declare variable $actualizaSistemasT241 as element(ns2:actualizaSistemasT24) external;

xf:actualizaciondeperfildeclienteIn($requestHeader1,
    $actualizaSistemasT241)