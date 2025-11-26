(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleRemesadoras" element="ns0:sjConsultaMultipleRemesadoras" location="../xsd/sjConsultaMultipleRemesadoras.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../armarMensajeRecaudo/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_ARMAR_MENSAJE.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_K_RECAUDOS_REF_ONLINE/OSB_ARMAR_MENSAJE/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleRemesadoras";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/xq/armarInfoParametrosRemesas/";



declare function xf:armarInfoParametrosRemesas($remittancePosition as xs:int,
    $sjConsultaMultipleRemesadoras as element(ns0:sjConsultaMultipleRemesadoras))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $AGREEMENT_ID_T24 in $sjConsultaMultipleRemesadoras/ns0:TYPES_REMITTANCE/ns0:TYPES_REMITTANCE_ITEM[$remittancePosition]/ns0:AGREEMENT_ID_T24
                return
                    <ns1:CODIGO_CONTRATO>{ data($AGREEMENT_ID_T24) }</ns1:CODIGO_CONTRATO>
            }
            <ns1:TIPO_OPERACION>1</ns1:TIPO_OPERACION>
            <ns1:TIPO_PARAM>REQ</ns1:TIPO_PARAM>
            <ns1:APLICACION>ENQ</ns1:APLICACION>
            <ns1:INFO>
                <ns1:DATA>
                    <ns1:NAME>corresponsalBranchCode</ns1:NAME>
                    {
                        for $CORRESPONSAL_BRANCHCODE in $sjConsultaMultipleRemesadoras/ns0:CORRESPONSAL_BRANCHCODE
                        return
                            <ns1:VALUE>{ data($CORRESPONSAL_BRANCHCODE) }</ns1:VALUE>
                    }
                </ns1:DATA>
                <ns1:DATA>
                    <ns1:NAME>primaryKey</ns1:NAME>
                    {
                        for $REMITTANCE_ID in $sjConsultaMultipleRemesadoras/ns0:REMITTANCE_ID
                        return
                            <ns1:VALUE>{ data($REMITTANCE_ID) }</ns1:VALUE>
                    }
                </ns1:DATA>
                <ns1:DATA>
                    <ns1:NAME>UserName</ns1:NAME>
                    {
                        for $USERNAME in $sjConsultaMultipleRemesadoras/ns0:USERNAME
                        return
                            <ns1:VALUE>{ data($USERNAME) }</ns1:VALUE>
                    }
                </ns1:DATA>
                <ns1:DATA>
                    <ns1:NAME>CONTRAC_ID</ns1:NAME>
                    {
		                for $PV_ID_CONVENIO_T24 in $sjConsultaMultipleRemesadoras/ns0:TYPES_REMITTANCE/ns0:TYPES_REMITTANCE_ITEM[$remittancePosition]/ns0:AGREEMENT_ID_T24
		                return
		                    <ns1:VALUE>{ data($PV_ID_CONVENIO_T24) }</ns1:VALUE>
		            }
                </ns1:DATA>                
                <ns1:DATA>
                	<ns1:NAME>coreRunningDate</ns1:NAME>
                    {
						let $currentDateTime := fn:adjust-dateTime-to-timezone(fn:current-dateTime())
						let $strDateTime := fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss",$currentDateTime)
						return (
							<ns1:VALUE>{ $strDateTime }</ns1:VALUE>
						)					
					}
                </ns1:DATA>
                <ns1:DATA>
                	<ns1:NAME>transactionID</ns1:NAME>
                    {
						let $currentDateTime := fn:adjust-dateTime-to-timezone(fn:current-dateTime())
						let $strDateTime := fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss",$currentDateTime)
						return (
							<ns1:VALUE>{ $strDateTime }</ns1:VALUE>
						)					
					}
                </ns1:DATA>
                <ns1:DATA>
                    <ns1:NAME>beneficiaryFirstName</ns1:NAME>
                    {
                        for $BENEFICIARY_FIRSTNAME in $sjConsultaMultipleRemesadoras/ns0:BENEFICIARY_FIRSTNAME
                        return
                            <ns1:VALUE>{ data($BENEFICIARY_FIRSTNAME) }</ns1:VALUE>
                    }
                </ns1:DATA>
                <ns1:DATA>
                    <ns1:NAME>beneficiaryMiddleName</ns1:NAME>
                    {
                        for $BENEFICIARY_MIDDLENAME in $sjConsultaMultipleRemesadoras/ns0:BENEFICIARY_MIDDLENAME
                        return
                            <ns1:VALUE>{ data($BENEFICIARY_MIDDLENAME) }</ns1:VALUE>
                    }
                </ns1:DATA>
                <ns1:DATA>
                    <ns1:NAME>beneficiaryFirstSurname</ns1:NAME>
                    {
                        for $BENEFICIARY_FIRSTSURNAME in $sjConsultaMultipleRemesadoras/ns0:BENEFICIARY_FIRSTSURNAME
                        return
                            <ns1:VALUE>{ data($BENEFICIARY_FIRSTSURNAME) }</ns1:VALUE>
                    }
                </ns1:DATA>
                <ns1:DATA>
                    <ns1:NAME>beneficiarySecondSurname</ns1:NAME>
                    {
                        for $BENEFICIARY_SECONDSURNAME in $sjConsultaMultipleRemesadoras/ns0:BENEFICIARY_SECONDSURNAME
                        return
                            <ns1:VALUE>{ data($BENEFICIARY_SECONDSURNAME) }</ns1:VALUE>
                    }
                    
                  </ns1:DATA>
                
	            
	           
                   {
                    for $INFO at $i  in $sjConsultaMultipleRemesadoras/ns0:ADDITIONAL_INFO/ns0:INFO
                    return
                    (
                           <ns1:DATA>
                                  <ns1:NAME>{data($INFO/ns0:NAME)}</ns1:NAME>
                                  <ns1:VALUE>{data($INFO/ns0:VALUE)}</ns1:VALUE>
                           </ns1:DATA>
                    )
                    }
                  
		       
                    
                        
                   
            </ns1:INFO>
             
                
            
           
        </ns1:InputParameters>
};

declare variable $remittancePosition as xs:int external;
declare variable $sjConsultaMultipleRemesadoras as element(ns0:sjConsultaMultipleRemesadoras) external;

xf:armarInfoParametrosRemesas($remittancePosition,
    $sjConsultaMultipleRemesadoras)