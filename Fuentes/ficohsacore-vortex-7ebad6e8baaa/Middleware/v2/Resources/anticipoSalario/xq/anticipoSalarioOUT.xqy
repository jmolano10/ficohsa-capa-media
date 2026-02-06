xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaAnticipoSalarioResponse1" element="ns0:ConsultaAnticipoSalarioResponse" location="../../../BusinessServices/T24/AnticipoSalario/xsd/AnticipoSalarioTypes02.xsd" ::)
(:: pragma bea:global-element-return element="ns1:anticipoSalarioResponse" location="../xsd/AnticipoSalarioTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/AnticipoSalarioTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/anticipoSalario/xq/anticipoSalarioOUT2/";
declare variable $amount as xs:decimal external;

declare function xf:anticipoSalarioOUT2($consultaAnticipoSalarioResponse1 as element(ns0:ConsultaAnticipoSalarioResponse))
    as element(ns1:anticipoSalarioResponse) {
        <ns1:anticipoSalarioResponse>
            <LIMIT_ADVANCE>{ data($consultaAnticipoSalarioResponse1/NOFILEFICOCASHADVANCEWSType[1]/gNOFILEFICOCASHADVANCEWSDetailType/mNOFILEFICOCASHADVANCEWSDetailType[1]/LIMITADVANCE) }</LIMIT_ADVANCE>
            <ADVANCED_AVAILABLE>{ data($consultaAnticipoSalarioResponse1/NOFILEFICOCASHADVANCEWSType[1]/gNOFILEFICOCASHADVANCEWSDetailType/mNOFILEFICOCASHADVANCEWSDetailType[1]/ADVANCEDAVAILABLE) }</ADVANCED_AVAILABLE>
            <CREDIT_ADVANCE>{ data($consultaAnticipoSalarioResponse1/NOFILEFICOCASHADVANCEWSType[1]/gNOFILEFICOCASHADVANCEWSDetailType/mNOFILEFICOCASHADVANCEWSDetailType[1]/CREDITADVANCE) }</CREDIT_ADVANCE>
            <COMMISSION_AMOUNT>{ data($consultaAnticipoSalarioResponse1/NOFILEFICOCASHADVANCEWSType[1]/gNOFILEFICOCASHADVANCEWSDetailType/mNOFILEFICOCASHADVANCEWSDetailType[1]/COMMISSIONAMOUNT) }</COMMISSION_AMOUNT>
            <COMMISSION_PERCENT>{ data($consultaAnticipoSalarioResponse1/NOFILEFICOCASHADVANCEWSType[1]/gNOFILEFICOCASHADVANCEWSDetailType/mNOFILEFICOCASHADVANCEWSDetailType[1]/COMMISSIONPERCENT) }</COMMISSION_PERCENT>
            <CREDIT_AMOUNT>{data($amount)}</CREDIT_AMOUNT>
        </ns1:anticipoSalarioResponse>
};

declare variable $consultaAnticipoSalarioResponse1 as element(ns0:ConsultaAnticipoSalarioResponse) external;

xf:anticipoSalarioOUT2($consultaAnticipoSalarioResponse1)