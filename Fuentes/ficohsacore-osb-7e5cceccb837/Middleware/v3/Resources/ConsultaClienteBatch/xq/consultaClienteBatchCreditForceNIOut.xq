(:: pragma bea:global-element-parameter parameter="$clientResponse" element="ns0:ClientResponse" location="../../../../v2/BusinessServices/CREDITFORCE/ficohsaServices/xsd/creditForce.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaClienteResponse" location="../../ConsultaCliente/xsd/consultaClientesTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "http://schemas.datacontract.org/2004/07/CreditForce.Common.DataContract.BackEnd.Collection";
declare namespace ns0 = "http://www.creditforce.com/SOA";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaClienteBatch/xq/consultaClienteBatchCreditForceOut/";

(: Devuelve el numero de telefono del cliente con el codigo de area :)
declare function convert-number($sourceBank as xs:string, $phoneNumber as xs:string) as xs:string {
	let $counter := string-length($phoneNumber)
	
	return
		if ($counter = 8) then(
		if ($sourceBank = 'NI01') then(
			concat('505', $phoneNumber)
		)else(
			concat('504', $phoneNumber)
		))else(
			$phoneNumber
		)
};

declare function xf:consultaClienteBatchCreditForceOut($sourceBank as xs:string, $clientResponse as element(ns0:ClientResponse))
    as element(ns2:consultaClienteResponse) {
    
        <ns2:consultaClienteResponse>
            {
                for $clientId in $clientResponse/ns0:ClientResult/ns1:Client/ns1:Client_Id
                return
                    <ns2:CUSTOMER_ID>{ data($clientId) }</ns2:CUSTOMER_ID>
            }
            <ns2:IDENTIFICATION_INFO>
                <ns2:LEGAL_IDENTIFICATION_ITEM>
                    <ns2:LEGAL_ID>{ data($clientResponse/ns0:ClientResult/ns1:Client/ns1:Identification) }</ns2:LEGAL_ID>
                </ns2:LEGAL_IDENTIFICATION_ITEM>
            </ns2:IDENTIFICATION_INFO>
            {
                for $FullName in $clientResponse/ns0:ClientResult/ns1:Client/ns1:FullName
                return
                    <ns2:FULL_NAME>{ data($FullName) }</ns2:FULL_NAME>
            }
            {
                for $Marital_Status in $clientResponse/ns0:ClientResult/ns1:Client/ns1:Marital_Status
                return
                    <ns2:MARITAL_STATUS>{ data($Marital_Status) }</ns2:MARITAL_STATUS>
            }
            {
                for $Position in $clientResponse/ns0:ClientResult/ns1:Client/ns1:Position
                return
                    <ns2:OCCUPATION>{ data($Position) }</ns2:OCCUPATION>
            }
            {
                for $WorkPlace in $clientResponse/ns0:ClientResult/ns1:Client/ns1:WorkPlace
                return
                    <ns2:EMPLOYERS_NAME>{ data($WorkPlace) }</ns2:EMPLOYERS_NAME>
            }
            {
            	let $phoneCounter := 0
            	return
		            <ns2:PHONE_INFO>
			            {
			                for $LastContactPhone in $clientResponse/ns0:ClientResult/ns1:Client/ns1:Last_Contact_Phone
			                let $phoneCounter := $phoneCounter + 1
			                return 	                
			                if ($LastContactPhone != '') then (
			                	<ns2:PHONE_NUMBER_ITEM>
			            			<ns2:PHONE_TYPE>SMS</ns2:PHONE_TYPE>
			            			<ns2:PHONE_NUMBER>{ convert-number($sourceBank, concat($LastContactPhone)) }</ns2:PHONE_NUMBER>
			            			<ns2:PHONE_ORDER>{ $phoneCounter }</ns2:PHONE_ORDER>
			            			<ns2:PHONE_EXTENSION/>
			            			<ns2:PHONE_REFERRENCE>ULTIMO TELEFONO CONTACTO</ns2:PHONE_REFERRENCE>
			            		</ns2:PHONE_NUMBER_ITEM>
			                ) else()
			            		
			            }
			            {
			                for $CellPhone in $clientResponse/ns0:ClientResult/ns1:Client/ns1:CellPhone
			                let $phoneCounter := $phoneCounter + 1
			                return 	                
			                if ($CellPhone != '') then (
			                	<ns2:PHONE_NUMBER_ITEM>
			            			<ns2:PHONE_TYPE>SMS</ns2:PHONE_TYPE>
			            			<ns2:PHONE_NUMBER>{ convert-number($sourceBank, concat($CellPhone)) }</ns2:PHONE_NUMBER>
			            			<ns2:PHONE_ORDER>{ $phoneCounter }</ns2:PHONE_ORDER>
			            			<ns2:PHONE_EXTENSION/>
			            			<ns2:PHONE_REFERRENCE>MOVIL</ns2:PHONE_REFERRENCE>
			            		</ns2:PHONE_NUMBER_ITEM>
			                ) else()
			            		
			            }
			            {
			                for $CellPhone_2 in $clientResponse/ns0:ClientResult/ns1:Client/ns1:CellPhone_2
			                let $phoneCounter := $phoneCounter + 1
			                return
				                if ($CellPhone_2 != '') then (
				                	<ns2:PHONE_NUMBER_ITEM>
				            			<ns2:PHONE_TYPE>PHONE</ns2:PHONE_TYPE>
				            			<ns2:PHONE_NUMBER>{ convert-number($sourceBank, concat($CellPhone_2)) }</ns2:PHONE_NUMBER>
				            			<ns2:PHONE_ORDER>{ $phoneCounter }</ns2:PHONE_ORDER>
				            			<ns2:PHONE_EXTENSION/>
				            			<ns2:PHONE_REFERRENCE>MOVIL</ns2:PHONE_REFERRENCE>
				            		</ns2:PHONE_NUMBER_ITEM>
				                )else()
			            		
			            }
			            {
			                for $Home_Phone in $clientResponse/ns0:ClientResult/ns1:Client/ns1:Home_Phone
			                let $phoneCounter := $phoneCounter + 1
			                return
			                	if ($Home_Phone != '') then (
				                	<ns2:PHONE_NUMBER_ITEM>
				            			<ns2:PHONE_TYPE>PHONE</ns2:PHONE_TYPE>
				            			<ns2:PHONE_NUMBER>{ convert-number($sourceBank, concat($Home_Phone)) }</ns2:PHONE_NUMBER>
				            			<ns2:PHONE_ORDER>{ $phoneCounter }</ns2:PHONE_ORDER>
				            			<ns2:PHONE_EXTENSION/>
				            			<ns2:PHONE_REFERRENCE>CASA</ns2:PHONE_REFERRENCE>
				            		</ns2:PHONE_NUMBER_ITEM>
			                	) else()	            		
			            }
			            {
			                for $Home_Phone_2 in $clientResponse/ns0:ClientResult/ns1:Client/ns1:Home_Phone_2
			                let $phoneCounter := $phoneCounter + 1
			                return
			                	if($Home_Phone_2 != '') then(
				                	<ns2:PHONE_NUMBER_ITEM>
				            			<ns2:PHONE_TYPE>PHONE</ns2:PHONE_TYPE>
				            			<ns2:PHONE_NUMBER>{ convert-number($sourceBank, concat($Home_Phone_2)) }</ns2:PHONE_NUMBER>
				            			<ns2:PHONE_ORDER>{ $phoneCounter }</ns2:PHONE_ORDER>
				            			<ns2:PHONE_EXTENSION/>
				            			<ns2:PHONE_REFERRENCE>CASA</ns2:PHONE_REFERRENCE>
				            		</ns2:PHONE_NUMBER_ITEM>
			                	) else()
			            		
			            }
			            {
			                for $Company_Phone in $clientResponse/ns0:ClientResult/ns1:Client/ns1:Company_Phone
			                let $phoneCounter := $phoneCounter + 1
			                return
			                if ($Company_Phone != '') then (
			            		<ns2:PHONE_NUMBER_ITEM>
			            			<ns2:PHONE_TYPE>PHONE</ns2:PHONE_TYPE>
			            			<ns2:PHONE_NUMBER>{ convert-number($sourceBank, concat($Company_Phone)) }</ns2:PHONE_NUMBER>
			            			<ns2:PHONE_ORDER>{ $phoneCounter }</ns2:PHONE_ORDER>
			            			<ns2:PHONE_EXTENSION/>
			            			<ns2:PHONE_REFERRENCE>TRABAJO</ns2:PHONE_REFERRENCE>
			            		</ns2:PHONE_NUMBER_ITEM>
			            		)else()
			            }
			            {
			                for $Company_Phone_2 in $clientResponse/ns0:ClientResult/ns1:Client/ns1:Company_Phone_2
			                let $phoneCounter := $phoneCounter + 1
			                return
			                	if ($Company_Phone_2 != '') then (
				            		<ns2:PHONE_NUMBER_ITEM>
				            			<ns2:PHONE_TYPE>PHONE</ns2:PHONE_TYPE>
				            			<ns2:PHONE_NUMBER>{ convert-number($sourceBank, concat($Company_Phone_2)) }</ns2:PHONE_NUMBER>
				            			<ns2:PHONE_ORDER>{ $phoneCounter }</ns2:PHONE_ORDER>
				            			<ns2:PHONE_EXTENSION/>
				            			<ns2:PHONE_REFERRENCE>TRABAJO</ns2:PHONE_REFERRENCE>
				            		</ns2:PHONE_NUMBER_ITEM>
			                	)else()
			            }
		            </ns2:PHONE_INFO>
		     } 
            <ns2:ADDRESS_INFO>
                <ns2:ADDRESS_ITEM>
                    {
                        for $Address in $clientResponse/ns0:ClientResult/ns1:Client/ns1:Address
                        return
                            <ns2:ADDRESS_LINE_1>{ data($Address) }</ns2:ADDRESS_LINE_1>
                    }
                </ns2:ADDRESS_ITEM>
            </ns2:ADDRESS_INFO>
            <ns2:EMAIL_INFO>
                <ns2:EMAIL_ITEM>
                    {
                        for $Email in $clientResponse/ns0:ClientResult/ns1:Client/ns1:Email
                        return
                            <ns2:EMAIL_ADDRESS>{ data($Email) }</ns2:EMAIL_ADDRESS>
                    }
                </ns2:EMAIL_ITEM>
            </ns2:EMAIL_INFO>
            <ns2:JOB_INFO>
                <ns2:JOB_ITEM>
                	{
                        for $Salary in $clientResponse/ns0:ClientResult/ns1:Client/ns1:Salary
                        return
                            <ns2:SALARY_AMOUNT>{ data($Salary) }</ns2:SALARY_AMOUNT>
                    }
                </ns2:JOB_ITEM>
            </ns2:JOB_INFO>
        </ns2:consultaClienteResponse>
};

declare variable $clientResponse as element(ns0:ClientResponse) external;
declare variable $sourceBank as xs:string external;

xf:consultaClienteBatchCreditForceOut($sourceBank, $clientResponse)