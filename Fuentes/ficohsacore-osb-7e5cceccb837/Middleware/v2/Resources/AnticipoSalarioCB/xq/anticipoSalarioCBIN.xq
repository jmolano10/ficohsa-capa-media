(:: pragma bea:global-element-parameter parameter="$anticipoSalarioRequest1" element="ns0:anticipoSalarioRequest" location="../xsd/anticipoSalarioCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:anticipoSalarioRequest" location="../../anticipoSalario/xsd/AnticipoSalarioTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/AnticipoSalarioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AnticipoSalarioCB/xq/anticipoSalarioCBIN/";

declare function xf:anticipoSalarioCBIN($anticipoSalarioRequest1 as element(ns0:anticipoSalarioRequest))
    as element(ns0:anticipoSalarioRequest) {
        <ns0:anticipoSalarioRequest>
            <ACCOUNT>{ data($anticipoSalarioRequest1/ACCOUNT) }</ACCOUNT>
            <AMOUNT>{ data($anticipoSalarioRequest1/AMOUNT) }</AMOUNT>
        </ns0:anticipoSalarioRequest>
};

declare variable $anticipoSalarioRequest1 as element(ns0:anticipoSalarioRequest) external;

xf:anticipoSalarioCBIN($anticipoSalarioRequest1)