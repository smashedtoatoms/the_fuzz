defmodule MetaphoneAlgorithmTest do
  use ExUnit.Case

  import TheFuzz.Phonetic.MetaphoneAlgorithm, only: [compute: 1]

  test "returns nil with empty argument" do
    assert compute("") == nil
  end

  test "returns nil with non-phonetic argument" do
    assert compute("123") == nil
  end

  test "return the expected phonetic responses" do
    # z
    assert compute("z") == "s"
    assert compute("zz") == "s"

    # y
    assert compute("y") == nil
    assert compute("zy") == "s"
    assert compute("zyz") == "ss"
    assert compute("zya") == "sy"

    # x
    assert compute("x") == "s"
    assert compute("zx") == "sks"
    assert compute("zxz") == "skss"

    # w
    assert compute("w") == nil
    assert compute("zw") == "s"
    assert compute("zwz") == "ss"
    assert compute("zwa") == "sw"

    # v
    assert compute("v") == "f"
    assert compute("zv") == "sf"
    assert compute("zvz") == "sfs"

    # u
    assert compute("u") == "u"
    assert compute("zu") == "s"

    # t
    assert compute("t") == "t"
    assert compute("ztiaz") == "sxs"
    assert compute("ztioz") == "sxs"
    assert compute("zthz") == "s0s"
    assert compute("ztchz") == "sxs"
    assert compute("ztz") == "sts"

    # s
    assert compute("s") == "s"
    assert compute("zshz") == "sxs"
    assert compute("zsioz") == "sxs"
    assert compute("zsiaz") == "sxs"
    assert compute("zs") == "ss"
    assert compute("zsz") == "sss"

    # r
    assert compute("r") == "r"
    assert compute("zr") == "sr"
    assert compute("zrz") == "srs"

    # q
    assert compute("q") == "k"
    assert compute("zq") == "sk"
    assert compute("zqz") == "sks"

    # p
    assert compute("p") == "p"
    assert compute("zp") == "sp"
    assert compute("zph") == "sf"
    assert compute("zpz") == "sps"

    # o
    assert compute("o") == "o"
    assert compute("zo") == "s"

    # n
    assert compute("n") == "n"
    assert compute("zn") == "sn"
    assert compute("znz") == "sns"

    # m
    assert compute("m") == "m"
    assert compute("zm") == "sm"
    assert compute("zmz") == "sms"

    # l
    assert compute("l") == "l"
    assert compute("zl") == "sl"
    assert compute("zlz") == "sls"

    # k
    assert compute("k") == "k"
    assert compute("zk") == "sk"
    assert compute("zck") == "sk"

    # j
    assert compute("j") == "j"
    assert compute("zj") == "sj"
    assert compute("zjz") == "sjs"

    # i
    assert compute("i") == "i"
    assert compute("zi") == "s"

    # h
    # php wrongly says nil
    assert compute("h") == "h"
    # php wrongly says s
    assert compute("zh") == "sh"
    assert compute("zah") == "s"
    assert compute("zchh") == "sx"
    assert compute("ha") == "h"

    # g
    assert compute("g") == "k"
    assert compute("zg") == "sk"
    # php wrongly says sf
    assert compute("zgh") == "skh"
    # php wrongly says sfs
    assert compute("zghz") == "shs"
    # php wrongly says sf
    assert compute("zgha") == "sh"
    # others wrongly say skh
    assert compute("zgn") == "sn"
    assert compute("zgns") == "skns"
    # others wrongly says sknt
    assert compute("zgned") == "snt"
    # php wrongly says snts
    assert compute("zgneds") == "sknts"
    assert compute("zgi") == "sj"
    assert compute("zgiz") == "sjs"
    assert compute("zge") == "sj"
    assert compute("zgez") == "sjs"
    assert compute("zgy") == "sj"
    assert compute("zgyz") == "sjs"
    assert compute("zgz") == "sks"

    # f
    assert compute("f") == "f"
    assert compute("zf") == "sf"
    assert compute("zfz") == "sfs"

    # e
    assert compute("e") == "e"
    assert compute("ze") == "s"

    # d
    assert compute("d") == "t"
    # php wrongly says fj
    assert compute("fudge") == "fjj"
    # php wrongly says tj
    assert compute("dodgy") == "tjj"
    # others wrongly say tjjy
    # php wrongly says tj
    assert compute("dodgi") == "tjj"
    assert compute("zd") == "st"
    assert compute("zdz") == "sts"

    # c
    assert compute("c") == "k"
    assert compute("zcia") == "sx"
    assert compute("zciaz") == "sxs"
    assert compute("zch") == "sx"
    assert compute("zchz") == "sxs"
    assert compute("zci") == "ss"
    assert compute("zciz") == "sss"
    assert compute("zce") == "ss"
    assert compute("zcez") == "sss"
    assert compute("zcy") == "ss"
    assert compute("zcyz") == "sss"
    assert compute("zsci") == "ss"
    assert compute("zsciz") == "sss"
    assert compute("zsce") == "ss"
    assert compute("zscez") == "sss"
    assert compute("zscy") == "ss"
    assert compute("zscyz") == "sss"
    # php wrongly says ssx
    assert compute("zsch") == "sskh"
    assert compute("zc") == "sk"
    assert compute("zcz") == "sks"

    # b
    assert compute("b") == "b"
    assert compute("zb") == "sb"
    assert compute("zbz") == "sbs"
    assert compute("zmb") == "sm"

    # a
    assert compute("a") == "a"
    assert compute("za") == "s"

    # Miscellaneous.
    assert compute("dumb") == "tm"
    assert compute("smith") == "sm0"
    # php wrongly says sxl
    assert compute("school") == "skhl"
    assert compute("merci") == "mrs"
    assert compute("cool") == "kl"
    assert compute("aebersold") == "ebrslt"
    assert compute("gnagy") == "nj"
    assert compute("knuth") == "n0"
    assert compute("pniewski") == "nsk"
    # php wrongly says rft
    assert compute("wright") == "rht"
    assert compute("phone") == "fn"
    assert compute("aggregate") == "akrkt"
    assert compute("accuracy") == "akkrs"
    assert compute("encyclopedia") == "ensklpt"
    assert compute("honorificabilitudinitatibus") == "hnrfkblttnttbs"
    assert compute("antidisestablishmentarianism") == "anttsstblxmntrnsm"
  end
end
