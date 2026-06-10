<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaRemesas" element="ns1:consultaRemesas" location="../xsd/consultaRemesasTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../BusinessServices/MDW/obtenerTipoRemesadoraNI/xsd/ObtenerTipoRemesadora_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaMultipleRemesadorasNI" location="../../../BusinessServices/SJS/consultaMultipleRemesadorasNI/xsd/sjConsultaMultipleRemesadorasNI.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerTipoRemesadora";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleRemesadorasNI";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/sjConsultaRemesasNIIn/";

declare function xf:sjConsultaRemesasNIIn($consultaRemesas as element(ns1:consultaRemesas),
    $outputParameters as element(ns2:OutputParameters))
    as element(ns0:sjConsultaMultipleRemesadorasNI) {
        <ns0:sjConsultaMultipleRemesadorasNI>
            <ns0:REMITTANCE_ID>{ data($consultaRemesas/REMITTANCE_ID) }</ns0:REMITTANCE_ID>
            {
            	for $PT_TIPOS_REMESADORAS in $outputParameters/ns2:PT_TIPOS_REMESADORAS
                return
                    <ns0:REMITTANCE_TYPES>
                        {
                            for $PT_TIPOS_REMESADORAS_ITEM in $PT_TIPOS_REMESADORAS/ns2:PT_TIPOS_REMESADORAS_ITEM
                            return
                                <ns0:REMITTANCE_TYPES_ITEM>
                                    {
                                        for $PV_NOMBRE_REMESADORA in $PT_TIPOS_REMESADORAS_ITEM/ns2:PV_NOMBRE_REMESADORA
                                        return
                                            <ns0:REMITTANCE_NAME>{ data($PV_NOMBRE_REMESADORA) }</ns0:REMITTANCE_NAME>
                                    }
                                    {
                                        for $PV_TIPO_REMESADORA in $PT_TIPOS_REMESADORAS_ITEM/ns2:PV_TIPO_REMESADORA
                                        return
                                            <ns0:REMITTANCE_TYPE>{ data($PV_TIPO_REMESADORA) }</ns0:REMITTANCE_TYPE>
                                    }
                                    {
                                        for $PN_ID_CONVENIO in $PT_TIPOS_REMESADORAS_ITEM/ns2:PN_ID_CONVENIO
                                        return
                                            <ns0:AGREEMENT_ID>{ data($PN_ID_CONVENIO) }</ns0:AGREEMENT_ID>
                                    }
                                    {
                                        for $PV_ABREVIATURA_REMESADORA in $PT_TIPOS_REMESADORAS_ITEM/ns2:PV_ABREVIATURA_REMESADORA
                                        return
                                            <ns0:REMITTANCE_ABBREVIATION>{ data($PV_ABREVIATURA_REMESADORA) }</ns0:REMITTANCE_ABBREVIATION>
                                    }
                                    {
                                        for $PN_PRIORIDAD in $PT_TIPOS_REMESADORAS_ITEM/ns2:PN_PRIORIDAD
                                        return
                                            <ns0:PRIORITY>{ data($PN_PRIORIDAD) }</ns0:PRIORITY>
                                    }
                                </ns0:REMITTANCE_TYPES_ITEM>
                        }
                    </ns0:REMITTANCE_TYPES>
            }
        </ns0:sjConsultaMultipleRemesadorasNI>
};

declare variable $consultaRemesas as element(ns1:consultaRemesas) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;

xf:sjConsultaRemesasNIIn($consultaRemesas,
    $outputParameters)]]></con:xquery>
    <con:dependency location="../xsd/consultaRemesasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaRemesas/xsd/consultaRemesasTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MDW/obtenerTipoRemesadoraNI/xsd/ObtenerTipoRemesadora_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MDW/obtenerTipoRemesadoraNI/xsd/ObtenerTipoRemesadora_sp"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/SJS/consultaMultipleRemesadorasNI/xsd/sjConsultaMultipleRemesadorasNI.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadorasNI/xsd/sjConsultaMultipleRemesadorasNI"/>
    </con:dependency>
</con:xqueryEntry>