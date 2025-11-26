(:: pragma bea:global-element-parameter parameter="$consultaUltimaChequeraResponse1" element="ns0:ConsultaUltimaChequeraResponse" location="../Resources/XMLSchema_1756805255.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaChequerasResponse" location="../ConsultaChequeras/consultaChequerasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaChequerasTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/impresionChequeras/consultaUltimaChequera/consultaUltimaChequeraCuentaOut/";

declare function xf:consultaUltimaChequeraCuentaOut($consultaUltimaChequeraResponse1 as element(ns0:ConsultaUltimaChequeraResponse))
    as element(ns1:consultaChequerasResponse) {
        <ns1:consultaChequerasResponse>
            <ns1:consultaChequerasResponseType>
                {
                	if (empty($consultaUltimaChequeraResponse1/WSCHECKBOOKREQUESTENQLASTType[1]/ZERORECORDS/text())) then (
                	
	                	for $WSCHECKBOOKREQUESTENQLASTType in $consultaUltimaChequeraResponse1/WSCHECKBOOKREQUESTENQLASTType
	                    return
	                        <ns1:consultaChequerasResponseRecordType>
	                            <CHEQUEBOOK_ID>{ data($WSCHECKBOOKREQUESTENQLASTType/IDVAL) }</CHEQUEBOOK_ID>
	                            <ACCOUNT_NUMBER>{ data($WSCHECKBOOKREQUESTENQLASTType/ACCOUNTNUMBER) }</ACCOUNT_NUMBER>
	                            <ALT_ACCOUNT>{ data($WSCHECKBOOKREQUESTENQLASTType/ALTACCTNUMBER) }</ALT_ACCOUNT>
	                            <CURRENCY>{ data($WSCHECKBOOKREQUESTENQLASTType/CURRENCY) }</CURRENCY>
	                            <CUSTOMER_ID>{ data($WSCHECKBOOKREQUESTENQLASTType/CUSTOMERID) }</CUSTOMER_ID>
	                            <ACCOUNT_NAME>{ data($WSCHECKBOOKREQUESTENQLASTType/ACCOUNTNAME) }</ACCOUNT_NAME>
	                            <NAME_ON_CHEQUEBOOK>{ data($WSCHECKBOOKREQUESTENQLASTType/NAMEONCHECKBOOK) }</NAME_ON_CHEQUEBOOK>
	                            <PRODUCT_DESCRIPTION>{ data($WSCHECKBOOKREQUESTENQLASTType/CATEGORYDESCRIPTION) }</PRODUCT_DESCRIPTION>
	                            <REQUEST_DATE>{ data($WSCHECKBOOKREQUESTENQLASTType/REQUESTDATE) }</REQUEST_DATE>
	                            <DESTINATION_BRANCH_ID>{ data($WSCHECKBOOKREQUESTENQLASTType/BRANCHCODE) }</DESTINATION_BRANCH_ID>
	                            <DESTINATION_BRANCH_NAME>{ data($WSCHECKBOOKREQUESTENQLASTType/BRANCHNAME) }</DESTINATION_BRANCH_NAME>
	                            <PRINT_ZONE>{ data($WSCHECKBOOKREQUESTENQLASTType/PRINTZONE) }</PRINT_ZONE>
	                            <CHEQUEBOOK_TYPE>{ data($WSCHECKBOOKREQUESTENQLASTType/CHEQUEBOOKTYPEID) }</CHEQUEBOOK_TYPE>
	                            <CHEQUEBOOK_TYPE_DESC>{ data($WSCHECKBOOKREQUESTENQLASTType/CHECKBOOKTYPEDESC) }</CHEQUEBOOK_TYPE_DESC>
	                            <NUMBER_OF_BOOKS>{ data($WSCHECKBOOKREQUESTENQLASTType/NOOFBOOKS) }</NUMBER_OF_BOOKS>
	                            <CHEQUES_PER_BOOK>{ data($WSCHECKBOOKREQUESTENQLASTType/CHECKSPERBOOK) }</CHEQUES_PER_BOOK>
	                            <INITIAL_CHEQUE_NUMBER>{ data($WSCHECKBOOKREQUESTENQLASTType/CHEQUENOSTART) }</INITIAL_CHEQUE_NUMBER>
	                            <FINAL_CHEQUE_NUMBER>{ data($WSCHECKBOOKREQUESTENQLASTType/CHEQUENOEND) }</FINAL_CHEQUE_NUMBER>
	                            <CHEQUEBOOK_STATUS>{ data($WSCHECKBOOKREQUESTENQLASTType/STATUS) }</CHEQUEBOOK_STATUS>
	                            <CHQBK_PRINT_STATUS>{ data($WSCHECKBOOKREQUESTENQLASTType/PRINTSTATUS) }</CHQBK_PRINT_STATUS>
	                            <ADDRESS>{ data($WSCHECKBOOKREQUESTENQLASTType/ADDRESS) }</ADDRESS>
	                            <TELEPHONE>{ data($WSCHECKBOOKREQUESTENQLASTType/TELEPHONE) }</TELEPHONE>
	                            <FAX>{ data($WSCHECKBOOKREQUESTENQLASTType/FAX) }</FAX>
	                            <CONVERGING_CITY>{ data($WSCHECKBOOKREQUESTENQLASTType/CONVERGINGCITY) }</CONVERGING_CITY>
	                            <INPUTTER>{ data($WSCHECKBOOKREQUESTENQLASTType/INPUTTER) }</INPUTTER>
	                        </ns1:consultaChequerasResponseRecordType>
                	
				   )else (
				   
				   		
				   		
				   )
                    
                }
            </ns1:consultaChequerasResponseType>
        </ns1:consultaChequerasResponse>
};

declare variable $consultaUltimaChequeraResponse1 as element(ns0:ConsultaUltimaChequeraResponse) external;

xf:consultaUltimaChequeraCuentaOut($consultaUltimaChequeraResponse1)