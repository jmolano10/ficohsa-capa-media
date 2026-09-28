(:: pragma bea:global-element-return element="ns0:creaCuentaClienteResponse" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaCuentaCliente/xq/creaCuentaClienteOut/";

declare function xf:creaCuentaClienteOut($errorCodeCustomer as xs:string,
    $validationMessageCustomer as xs:string,
    $customerID as xs:string,
    $errorCodeAccount as xs:string,
    $validationMessageAccount as xs:string,
    $accountNumber as xs:string,
    $errorCodeUser as xs:string,
    $validationMessageUser as xs:string,
    $userID as xs:string,
    $errorCodeCard as xs:string,
    $validationMessageCard as xs:string,
    $referenceNumber as xs:string,
    $errorIDCard as xs:string,
    $errorIDAccount as xs:string,
    $errorIDCustomer as xs:string,
    $errorIDUser as xs:string)
    as element(ns0:creaCuentaClienteResponse) {
        <ns0:creaCuentaClienteResponse>
            {
	            if ($errorCodeCustomer != "") then (
            <CUSTOMER_INFORMATION>
            {
		        if ($customerID != "") then (
                <CUSTOMER_ID>{ $customerID }</CUSTOMER_ID>
                ) else (
						    )
				    	}
				  {
		            if ($errorIDCustomer != "0") then (
				        <MESSAGE_ID>{ $errorIDCustomer }</MESSAGE_ID>
				    ) else (
				    )
		    	}
                <SUCCESS_INDICATOR>{ $errorCodeCustomer }</SUCCESS_INDICATOR>
                {
		            if ($validationMessageCustomer != "") then (
				        <ERROR_MESSAGE>{ $validationMessageCustomer }</ERROR_MESSAGE>
				    ) else (
				    )
		    	}
                
            </CUSTOMER_INFORMATION>
                ) else (
			    )
		    }
            {
	            if ($errorCodeAccount != "") then (
            <ACCOUNT_INFORMATION>
            {
		        if ($accountNumber != "") then (
                <ACCOUNT_NUMBER>{ $accountNumber }</ACCOUNT_NUMBER>
                ) else (
						    )
				    	}
				 {
		            if ($errorIDAccount != "0") then (
				        <MESSAGE_ID>{ $errorIDAccount }</MESSAGE_ID>
				    ) else (
				    )
		    	}
                <SUCCESS_INDICATOR>{ $errorCodeAccount }</SUCCESS_INDICATOR>
                {
		            if ($validationMessageAccount != "") then (
				        <ERROR_MESSAGE>{ $validationMessageAccount }</ERROR_MESSAGE>
				    ) else (
				    )
		    	}
                
            </ACCOUNT_INFORMATION>
                ) else (
			    )
		    }
		    {
	            if ($errorCodeUser != "") then (
            <USER_INFORMATION>
            {
		        if ($userID != "") then (
                <USER_ID>{ $userID }</USER_ID>
                ) else (
						    )
				    	}
				    	 {
		           if ($errorIDUser != "0") then (
			   <MESSAGE_ID>{ $errorIDUser }</MESSAGE_ID>
				    ) else (
				    )
		    	}
                <SUCCESS_INDICATOR>{ $errorCodeUser }</SUCCESS_INDICATOR>
                {
		            if ($validationMessageUser != "") then (
				        <ERROR_MESSAGE>{ $validationMessageUser }</ERROR_MESSAGE>
				    ) else (
				    )
		    	}
                
            </USER_INFORMATION>
                ) else (
			    )
		    }
            {
	            if ($errorCodeCard != "") then (
			        <CARD_INFORMATION>
			        	{
				            if ($referenceNumber != "") then (
						        <REFERENCE_NUMBER>{ $referenceNumber }</REFERENCE_NUMBER>
						    ) else (
						    )
				    	}
				    	 {
		               if ($errorIDCard != "0") then (
			            <MESSAGE_ID>{ $errorIDCard }</MESSAGE_ID>
				          ) else (
				        )
		    	        }
		                <SUCCESS_INDICATOR>{ $errorCodeCard }</SUCCESS_INDICATOR>
		                {
				            if ($validationMessageCard != "") then (
						        <ERROR_MESSAGE>{ $validationMessageCard }</ERROR_MESSAGE>
						    ) else (
						    )
				    	}
		            </CARD_INFORMATION>
			    ) else (
			    )
		    }
            
        </ns0:creaCuentaClienteResponse>
};

declare variable $errorCodeCustomer as xs:string external;
declare variable $validationMessageCustomer as xs:string external;
declare variable $customerID as xs:string external;
declare variable $errorCodeAccount as xs:string external;
declare variable $validationMessageAccount as xs:string external;
declare variable $accountNumber as xs:string external;
declare variable $errorCodeUser as xs:string external;
declare variable $validationMessageUser as xs:string external;
declare variable $userID as xs:string external;
declare variable $errorCodeCard as xs:string external;
declare variable $validationMessageCard as xs:string external;
declare variable $referenceNumber as xs:string external;
declare variable $errorIDCard as xs:string external;
declare variable $errorIDAccount as xs:string external;
declare variable $errorIDCustomer as xs:string external;
declare variable $errorIDUser as xs:string external;

xf:creaCuentaClienteOut($errorCodeCustomer,
    $validationMessageCustomer,
    $customerID,
    $errorCodeAccount,
    $validationMessageAccount,
    $accountNumber,
    $errorCodeUser,
    $validationMessageUser,
    $userID,
    $errorCodeCard,
    $validationMessageCard,
    $referenceNumber,
    $errorIDCard ,
    $errorIDAccount ,
    $errorIDCustomer ,
    $errorIDUser )