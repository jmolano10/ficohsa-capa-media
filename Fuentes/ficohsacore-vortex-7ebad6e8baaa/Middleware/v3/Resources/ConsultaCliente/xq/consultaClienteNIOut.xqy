xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParametersIN" element="ns0:OutputParameters" location="../../../../v2/BusinessServices/Cobis/ConsultaCliente/xsd/Consulta_Cliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaClienteResponse" location="../xsd/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/Consulta_Cliente";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaCliente/xq/consultaClienteNIOut/";

(: Retorna el tipo de persona :)
declare function type-of-person 
  ( $sector as xs:string )  as xs:string {
  if (fn:string($sector) = "Natural") then (
  	"N"
  ) else (
  	"J"
  )
};


declare function xf:consultaClienteNIOut($outputParametersIN as element(ns0:OutputParameters))
    as element(ns1:consultaClienteResponse) {
        <ns1:consultaClienteResponse>
           <ns1:CUSTOMER_ID>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='CUSTOMER_ID'])}</ns1:CUSTOMER_ID>
                <ns1:IDENTIFICATION_INFO>
	               <ns1:LEGAL_IDENTIFICATION_ITEM>
                                <ns1:LEGAL_DOCUMENT_NAME>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='LEGAL_DOC_NAME'])}</ns1:LEGAL_DOCUMENT_NAME>
                                <ns1:LEGAL_ID>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='LEGAL_ID'])}</ns1:LEGAL_ID>
                            </ns1:LEGAL_IDENTIFICATION_ITEM>	                    
                </ns1:IDENTIFICATION_INFO>
				<ns1:GIVEN_NAMES>{fn:replace(data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='GIVEN_NAMES']),"[Ññ]", "#")}</ns1:GIVEN_NAMES>
                <ns1:FAMILY_NAME>{fn:replace(data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='FAMILY_NAMES']),"[Ññ]", "#")}</ns1:FAMILY_NAME>
                <ns1:FULL_NAME>{fn:replace(data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='FULL_NAME']/text()),"[Ññ]", "#")}</ns1:FULL_NAME>
                <ns1:NAME_OF_BUSINESS>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='NAME_OF_BUSINESS'])}</ns1:NAME_OF_BUSINESS>
                <ns1:LEGAL_HOLDER_NAME>{fn:replace(data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='FULL_NAME']),"[Ññ]", "#")}</ns1:LEGAL_HOLDER_NAME>
               { 
                                    	if (count($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='DATE_OF_BIRTH']) >0) then (
                                        	 <ns1:DATE_OF_BIRTH/>
										) else ( <ns1:DATE_OF_BIRTH>
                	{fn-bea:dateTime-to-string-with-format("yyyyMMdd", data(data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='DATE_OF_BIRTH'])))}
        		                                 </ns1:DATE_OF_BIRTH> )                                         
                                 	}     
                <ns1:GENDER>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='GENDER'])}</ns1:GENDER>
                <ns1:NATIONALITY>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='NATIONALITY'])}</ns1:NATIONALITY>
                <ns1:RESIDENCE>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='CITY_CODE'])}</ns1:RESIDENCE>
                <ns1:TARGET>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='BUSINESS_SEGMENT'])}</ns1:TARGET>
                <ns1:TARGET_DESCRIPTION>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='BUSINESS_NAME'])}</ns1:TARGET_DESCRIPTION>
                <ns1:MARITAL_STATUS>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='MARITAL_STATUS'])}</ns1:MARITAL_STATUS>
                <ns1:CUSTOMER_TYPE>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='CUSTOMER_TYPE'])}</ns1:CUSTOMER_TYPE>
                <ns1:EMPLOYMENT_STATUS>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='EMPLOYMENT_STATUS'])}</ns1:EMPLOYMENT_STATUS>
                <ns1:EMPLOYERS_NAME>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='EMPLOYERS_NAME'])}</ns1:EMPLOYERS_NAME>
                <ns1:MARRIED_LAST_NAME>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='MARRIED_LAST_NAME'])}</ns1:MARRIED_LAST_NAME>
                <ns1:LEGAL_REP_NAME>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='LEGAL_REP_NAME']/text())}</ns1:LEGAL_REP_NAME>
                <ns1:LEGAL_REP_ID>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='LEGAL_REP_ID'])}</ns1:LEGAL_REP_ID>
                <ns1:TYPE_OF_COMPANY>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='TYPE_OF_COMPANY'])}</ns1:TYPE_OF_COMPANY>
                <ns1:PROFESSION>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='PROFESSION'])}</ns1:PROFESSION>
                <ns1:LEGAL_REP_HOME_PHONE>
                	{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='LEGAL_REP_HOME_PHONE']/text())}
                </ns1:LEGAL_REP_HOME_PHONE>
                <ns1:TYPE_OF_PERSON>{ type-of-person(data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='TYPE_OF_PERSON']))}</ns1:TYPE_OF_PERSON>
                <ns1:INPUT_USER>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='INPUT_USER'])}</ns1:INPUT_USER>
                <ns1:DATE_TIME>
                	{fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss", data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='DATE_TIME']))}
            	</ns1:DATE_TIME>
            	<ns1:BRANCH_CODE>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='BRANCH_CODE'])}</ns1:BRANCH_CODE>
                <ns1:NO_OF_DEPENDENTS>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='NO_OF_DEPENDENTES'])}</ns1:NO_OF_DEPENDENTS>
                <ns1:CUSTOMER_SINCE>
	                {fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='CUSTOMER_SINCE']))}
    			</ns1:CUSTOMER_SINCE>
    			<ns1:PHONE_INFO>
                    {
                        
                            <ns1:PHONE_NUMBER_ITEM>
                                <ns1:PHONE_NUMBER>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='PHONE'])}</ns1:PHONE_NUMBER>
                            </ns1:PHONE_NUMBER_ITEM>
                    }
                    {
                      
                            <ns1:PHONE_NUMBER_ITEM>
                                <ns1:PHONE_NUMBER>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='MOBILE NUMBER'])}</ns1:PHONE_NUMBER>
                                 (: Este es el codigo secuencial del numero de celular para NI :)
                                <ns1:PHONE_ORDER>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='MOBILE CODE'])}</ns1:PHONE_ORDER>
                            </ns1:PHONE_NUMBER_ITEM>
                    }
                </ns1:PHONE_INFO>
                  <ns1:ADDRESS_INFO>
                    {
                        for $direccion in $outputParametersIN/ns0:RowSet[2]/ns0:Row
                        return
                            <ns1:ADDRESS_ITEM>
                                <ns1:ADDRESS_TYPE>{data($direccion/ns0:Column[@name='ADDRESS_TYPE'])}</ns1:ADDRESS_TYPE>
                                <ns1:ZIPCODE></ns1:ZIPCODE>
                                <ns1:COUNTRY_CODE>{data($direccion/ns0:Column[@name='COUNTRY_CODE'])}</ns1:COUNTRY_CODE>
                                <ns1:DEPARTMENT_CODE>{data($direccion/ns0:Column[@name='DEPT_CODE'])}</ns1:DEPARTMENT_CODE>
                                <ns1:MUNICIPALITY_CODE>{data($direccion/ns0:Column[@name='MUN_CODE'])}</ns1:MUNICIPALITY_CODE>
                                <ns1:CITY_CODE>{data($direccion/ns0:Column[@name='CITY_CODE']/text())}</ns1:CITY_CODE>
                                <ns1:ADDRESS_LINE_1>{data($direccion/ns0:Column[@name='ADDRESS_LINE_1'])}</ns1:ADDRESS_LINE_1>
                                <ns1:IS_MAIN_ADDRESS>
                                	{ 
                                    	if (data($direccion/ns0:Column[@name='MAIN_ADDRESS_YES_NO']/text()) = "1") then (
                                        	"S"
										) else ( "N" )                                         
                                 	}
                        		</ns1:IS_MAIN_ADDRESS>
                            </ns1:ADDRESS_ITEM>
                    }
                </ns1:ADDRESS_INFO>
                <ns1:EMAIL_INFO>
                    <ns1:EMAIL_ITEM>
                        <ns1:EMAIL_ADDRESS>{data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='EMAIL']) }</ns1:EMAIL_ADDRESS>
                    </ns1:EMAIL_ITEM>
                </ns1:EMAIL_INFO>
                 <ns1:FAXES_INFO>
                    <ns1:FAX_ITEM>
                        <ns1:FAX>{ data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='FAX']) }</ns1:FAX>
                    </ns1:FAX_ITEM>
                </ns1:FAXES_INFO>
           <ns1:COSTUMER_FATCA>{ data($outputParametersIN/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name='FATCA CHECK']) }</ns1:COSTUMER_FATCA>
        </ns1:consultaClienteResponse>
};

declare variable $outputParametersIN as element(ns0:OutputParameters) external;

xf:consultaClienteNIOut($outputParametersIN)