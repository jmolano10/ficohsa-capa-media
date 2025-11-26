<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/sjGgetMultipleRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/sjGetMultipleRemittancesTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/AssembleMessageCollection";
(:: import schema at "../../../../ProviderServices/XSD/AssembleMessageCollection/AssembleMessageCollection_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $sjGetMultipleRemittances as element() (:: schema-element(ns1:sjGetMultipleRemittancesRequest) ::) external;
declare variable $remittancePosition as xs:int external;

declare function local:func($sjGetMultipleRemittances as element() (:: schema-element(ns1:sjGetMultipleRemittancesRequest) ::), 
                            $remittancePosition as xs:int) 
                            as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
     {
                for $AgreementIdT24 in $sjGetMultipleRemittances/ns1:TypesRemittance/ns1:TypesRemittanceItem[$remittancePosition]/ns1:AgreementIdT24
                return
                    <ns2:CODIGO_CONTRATO>{ data($AgreementIdT24) }</ns2:CODIGO_CONTRATO>
            }
            <ns2:TIPO_OPERACION>1</ns2:TIPO_OPERACION>
            <ns2:TIPO_PARAM>REQ</ns2:TIPO_PARAM>
            <ns2:APLICACION>ENQ</ns2:APLICACION>
            <ns2:INFO>
                <ns2:INFO_ITEM>
                    <ns2:NAME>corresponsalBranchCode</ns2:NAME>
                    {
                        for $CorresponsalBranchcode in $sjGetMultipleRemittances/ns1:CorresponsalBranchcode
                        return
                            <ns2:VALUE>{ data($CorresponsalBranchcode) }</ns2:VALUE>
                    }
                </ns2:INFO_ITEM>
                <ns2:INFO_ITEM>
                    <ns2:NAME>primaryKey</ns2:NAME>
                    {
                        for $RemittanceId in $sjGetMultipleRemittances/ns1:RemittanceId
                        return
                            <ns2:VALUE>{ data($RemittanceId) }</ns2:VALUE>
                    }
                </ns2:INFO_ITEM>
                <ns2:INFO_ITEM>
                    <ns2:NAME>UserName</ns2:NAME>
                    {
                        for $Username in $sjGetMultipleRemittances/ns1:Username
                        return
                            <ns2:VALUE>{ data($Username) }</ns2:VALUE>
                    }
                </ns2:INFO_ITEM>
                <ns2:INFO_ITEM>
                    <ns2:NAME>CONTRAC_ID</ns2:NAME>
                    {
		                for $PV_ID_CONVENIO_T24 in $sjGetMultipleRemittances/ns1:TypesRemittance/ns1:TypesRemittanceItem[$remittancePosition]/ns1:AgreementIdT24
		                return
		                    <ns2:VALUE>{ data($PV_ID_CONVENIO_T24) }</ns2:VALUE>
		            }
                </ns2:INFO_ITEM>                
                <ns2:INFO_ITEM>
                	<ns2:NAME>coreRunningDate</ns2:NAME>
                    {
						let $currentDateTime := fn:adjust-dateTime-to-timezone(fn:current-dateTime())
						let $strDateTime := fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss",$currentDateTime)
						return (
							<ns2:VALUE>{ $strDateTime }</ns2:VALUE>
						)					
					}
                </ns2:INFO_ITEM>
                <ns2:INFO_ITEM>
                	<ns2:NAME>transactionID</ns2:NAME>
                    {
						let $currentDateTime := fn:adjust-dateTime-to-timezone(fn:current-dateTime())
						let $strDateTime := fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss",$currentDateTime)
						return (
							<ns2:VALUE>{ $strDateTime }</ns2:VALUE>
						)					
					}
                </ns2:INFO_ITEM>
                <ns2:INFO_ITEM>
                    <ns2:NAME>beneficiaryFirstName</ns2:NAME>
                    {
                        for $BeneficiaryFirstname in $sjGetMultipleRemittances/ns1:BeneficiaryFirstname
                        return
                            <ns2:VALUE>{ data($BeneficiaryFirstname) }</ns2:VALUE>
                    }
                </ns2:INFO_ITEM>
                <ns2:INFO_ITEM>
                    <ns2:NAME>beneficiaryMiddleName</ns2:NAME>
                    {
                        for $BENEFICIARY_MIDDLENAME in $sjGetMultipleRemittances/ns1:BeneficiaryMiddlename
                        return
                            <ns2:VALUE>{ data($BENEFICIARY_MIDDLENAME) }</ns2:VALUE>
                    }
                </ns2:INFO_ITEM>
                <ns2:INFO_ITEM>
                    <ns2:NAME>beneficiaryFirstSurname</ns2:NAME>
                    {
                        for $BENEFICIARY_FIRSTSURNAME in $sjGetMultipleRemittances/ns1:BeneficiaryFirstname
                        return
                            <ns2:VALUE>{ data($BENEFICIARY_FIRSTSURNAME) }</ns2:VALUE>
                    }
                </ns2:INFO_ITEM>
                <ns2:INFO_ITEM>
                    <ns2:NAME>beneficiarySecondSurname</ns2:NAME>
                    {
                        for $BENEFICIARY_SECONDSURNAME in $sjGetMultipleRemittances/ns1:BeneficiarySecondsurname
                        return
                            <ns2:VALUE>{ data($BENEFICIARY_SECONDSURNAME) }</ns2:VALUE>
                    }
                    
                </ns2:INFO_ITEM>
                    {
                    for $INFO at $i  in $sjGetMultipleRemittances/ns1:AdditionalInfo/ns1:Info
                    return
                    (
                           <ns2:INFO_ITEM>
                                  <ns2:NAME>{data($INFO/ns1:Name)}</ns2:NAME>
                                  <ns2:VALUE>{data($INFO/ns1:Value)}</ns2:VALUE>
                           </ns2:INFO_ITEM>
                    )
                    }
                <ns2:INFO_ITEM>
                    <ns2:NAME>branchCode</ns2:NAME>
                    {
                        if ($sjGetMultipleRemittances/ns1:GeneralInfo/com:BranchId)
                        then <ns2:VALUE>{fn:data($sjGetMultipleRemittances/ns1:GeneralInfo/com:BranchId)}</ns2:VALUE>
                        else ()
                    }
                </ns2:INFO_ITEM>
            </ns2:INFO>
            <ns2:INFO_T24>
                <ns2:INFO_ITEM>
                    <ns2:NAME>branchCode</ns2:NAME>
                    {
                        if ($sjGetMultipleRemittances/ns1:GeneralInfo/com:BranchId)
                        then <ns2:VALUE>{fn:data($sjGetMultipleRemittances/ns1:GeneralInfo/com:BranchId)}</ns2:VALUE>
                        else ()
                    }
                </ns2:INFO_ITEM>
            </ns2:INFO_T24>
    </ns2:InputParameters>
};

local:func($sjGetMultipleRemittances, $remittancePosition)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../../../../MWBanking/Remittances/RequestorServices/XSD/sjGetMultipleRemittancesTypes.xsd">
            <con:schema ref="MWBanking/Remittances/RequestorServices/XSD/sjGetMultipleRemittancesTypes"/>
        </con:importSchema>
        <con:importSchema location="../../../../ProviderServices/XSD/AssembleMessageCollection/AssembleMessageCollection_sp.xsd">
            <con:schema ref="CoreBankingHN/ProviderServices/XSD/AssembleMessageCollection/AssembleMessageCollection_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>