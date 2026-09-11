package com.ficohsa.model.cardposition;

import java.util.Optional;

public record Region(String srcRg, String dstRg) {

    public Region(String srcRg, String dstRg){
        this.srcRg = Optional.ofNullable(srcRg)
                .map(String::toUpperCase)
                .orElse(null);
        this.dstRg = Optional.ofNullable(dstRg)
                .map(String::toUpperCase)
                .orElse(this.srcRg);
    }

    public String getJoined() {
        return srcRg + "-" + dstRg;
    }
}
