<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/getRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/getRemittances.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/sjGgetMultipleRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/sjGetMultipleRemittancesTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getRemittancesType";
(:: import schema at "../../../../ProviderServices/XSD/GetRemittancesType/getRemittancesType_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $GetRemittancesRequest as element() (:: schema-element(ns1:getRemittancesRequest) ::) external;
declare variable $getRemittancesTypeResponse as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $user as xs:string external;

declare function local:func($uuid as xs:string, 
                            $GetRemittancesRequest as element() (:: schema-element(ns1:getRemittancesRequest) ::), 
                            $getRemittancesTypeResponse as element() (:: schema-element(ns2:OutputParameters) ::), 
                            $user as xs:string) 
                            as element() (:: schema-element(ns3:sjGetMultipleRemittancesRequest) ::) {
    <ns3:sjGetMultipleRemittancesRequest>
            <ns3:GeneralInfo>
                {
                    if ($GetRemittancesRequest/ns1:GeneralInfo/com:SourceBank)
                    then <com:SourceBank>{fn:data($GetRemittancesRequest/ns1:GeneralInfo/com:SourceBank)}</com:SourceBank>
                    else ()
                }
                {
                    if ($GetRemittancesRequest/ns1:GeneralInfo/com:DestinationBank)
                    then <com:DestinationBank>{fn:data($GetRemittancesRequest/ns1:GeneralInfo/com:DestinationBank)}</com:DestinationBank>
                    else ()
                }
                {
                    if ($GetRemittancesRequest/ns1:GeneralInfo/com:BranchId)
                    then <com:BranchId>{fn:data($GetRemittancesRequest/ns1:GeneralInfo/com:BranchId)}</com:BranchId>
                    else ()
                }
            </ns3:GeneralInfo>
            <ns3:Uuid>{fn:data($uuid)}</ns3:Uuid>
            <ns3:Username>{ data($user) }</ns3:Username>
            {
                for $REMITTANCE_ID in $GetRemittancesRequest/ns1:RemittanceId
                return
                    <ns3:RemittanceId>{ data($REMITTANCE_ID) }</ns3:RemittanceId>
            }
            {
                for $CORRESPONSAL_BRANCHCODE in $GetRemittancesRequest/ns1:CorresponsalBranchcode
                return
                    <ns3:CorresponsalBranchcode>{ data($CORRESPONSAL_BRANCHCODE) }</ns3:CorresponsalBranchcode>
            }
            {
                for $BENEFICIARY_FIRSTNAME in $GetRemittancesRequest/ns1:BeneficiaryFirstname
                return
                    <ns3:BeneficiaryFirstname>{ data($BENEFICIARY_FIRSTNAME) }</ns3:BeneficiaryFirstname>
            }
            {
                for $BENEFICIARY_MIDDLENAME in $GetRemittancesRequest/ns1:BeneficiaryMiddlename
                return
                    <ns3:BeneficiaryMiddlename>{ data($BENEFICIARY_MIDDLENAME) }</ns3:BeneficiaryMiddlename>
            }
            {
                for $BENEFICIARY_FIRSTSURNAME in $GetRemittancesRequest/ns1:BeneficiaryFirstsurname
                return
                    <ns3:BeneficiaryFirstsurname>{ data($BENEFICIARY_FIRSTSURNAME) }</ns3:BeneficiaryFirstsurname>
            }
            {
                for $BENEFICIARY_SECONDSURNAME in $GetRemittancesRequest/ns1:BeneficiarySecondsurname
                return
                    <ns3:BeneficiarySecondsurname>{ data($BENEFICIARY_SECONDSURNAME) }</ns3:BeneficiarySecondsurname>
            }
            {
                for $PT_TIPOS_REMESADORAS in $getRemittancesTypeResponse/ns2:PT_TIPOS_REMESADORAS
                return
                    <ns3:TypesRemittance>
                        {
                            for $PT_TIPOS_REMESADORAS_ITEM in $PT_TIPOS_REMESADORAS/ns2:PT_TIPOS_REMESADORAS_ITEM
                            return
                                <ns3:TypesRemittanceItem>
                                    {
                                        for $PV_NOMBRE_REMESADORA in $PT_TIPOS_REMESADORAS_ITEM/ns2:PV_NOMBRE_REMESADORA
                                        return
                                            <ns3:NameRemittance>{ data($PV_NOMBRE_REMESADORA) }</ns3:NameRemittance>
                                    }
                                    {
                                        for $PV_TIPO_REMESADORA in $PT_TIPOS_REMESADORAS_ITEM/ns2:PV_TIPO_REMESADORA
                                        return
                                            <ns3:TypeRemittance>{ data($PV_TIPO_REMESADORA) }</ns3:TypeRemittance>
                                    }
                                    {
                                        for $PN_ID_CONVENIO in $PT_TIPOS_REMESADORAS_ITEM/ns2:PN_ID_CONVENIO
                                        return
                                            <ns3:AgreementId>{ data($PN_ID_CONVENIO) }</ns3:AgreementId>
                                    }
                                    {
                                        for $PV_ID_CONVENIO_T24 in $PT_TIPOS_REMESADORAS_ITEM/ns2:PV_ID_CONVENIO_T24
                                        return
                                            <ns3:AgreementIdT24>{ data($PV_ID_CONVENIO_T24) }</ns3:AgreementIdT24>
                                    }
                                    {
                                        for $PV_ABREVIATURA_REMESADORA in $PT_TIPOS_REMESADORAS_ITEM/ns2:PV_ABREVIATURA_REMESADORA
                                        return
                                            <ns3:AbbreviationRemittance>{ data($PV_ABREVIATURA_REMESADORA) }</ns3:AbbreviationRemittance>
                                    }
                                    {
                                        for $PN_PRIORIDAD in $PT_TIPOS_REMESADORAS_ITEM/ns2:PN_PRIORIDAD
                                        return
                                            <ns3:Priority>{ data($PN_PRIORIDAD) }</ns3:Priority>
                                    }
                                </ns3:TypesRemittanceItem>
                        }
                    </ns3:TypesRemittance>
            }
            {
                for $ADDITIONAL_INFO in $GetRemittancesRequest/ns1:AdditionalInfo
                return
                    <ns3:AdditionalInfo>
                        {
                            for $INFO in $ADDITIONAL_INFO/ns1:Info
                            return
                                <ns3:Info>
                                    {
                                        for $NAME in $INFO/ns1:Name
                                        return
                                            <ns3:Name>{ data($NAME) }</ns3:Name>
                                    }
                                    {
                                        for $VALUE in $INFO/ns1:Value
                                        return
                                            <ns3:Value>{ data($VALUE) }</ns3:Value>
                                    }
                                </ns3:Info>
                        }
                    </ns3:AdditionalInfo>
            }
        </ns3:sjGetMultipleRemittancesRequest>
};

local:func($uuid, $GetRemittancesRequest, $getRemittancesTypeResponse, $user)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../../../../MWBanking/Remittances/RequestorServices/XSD/getRemittances.xsd">
            <con:schema ref="MWBanking/Remittances/RequestorServices/XSD/getRemittances"/>
        </con:importSchema>
        <con:importSchema location="../../../../../MWBanking/Remittances/RequestorServices/XSD/sjGetMultipleRemittancesTypes.xsd">
            <con:schema ref="MWBanking/Remittances/RequestorServices/XSD/sjGetMultipleRemittancesTypes"/>
        </con:importSchema>
        <con:importSchema location="../../../../ProviderServices/XSD/GetRemittancesType/getRemittancesType_sp.xsd">
            <con:schema ref="CoreBankingHN/ProviderServices/XSD/GetRemittancesType/getRemittancesType_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>