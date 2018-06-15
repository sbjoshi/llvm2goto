; ModuleID = 'function_pointer1/main.c'
source_filename = "function_pointer1/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @f1(i32 %a, i32 %b) #0 !dbg !6 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !10, metadata !11), !dbg !12
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !13, metadata !11), !dbg !14
  %0 = load i32, i32* %a.addr, align 4, !dbg !15
  %1 = load i32, i32* %b.addr, align 4, !dbg !16
  %add = add nsw i32 %0, %1, !dbg !17
  %add1 = add nsw i32 %add, 1, !dbg !18
  ret i32 %add1, !dbg !19
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define i32 @f2(i32 %x, i32 %y) #0 !dbg !20 {
entry:
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !21, metadata !11), !dbg !22
  store i32 %y, i32* %y.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %y.addr, metadata !23, metadata !11), !dbg !24
  %0 = load i32, i32* %x.addr, align 4, !dbg !25
  %1 = load i32, i32* %y.addr, align 4, !dbg !26
  %sub = sub nsw i32 %0, %1, !dbg !27
  %add = add nsw i32 %sub, 2, !dbg !28
  ret i32 %add, !dbg !29
}

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !30 {
entry:
  %retval = alloca i32, align 4
  %res = alloca i32, align 4
  %pf = alloca i32 (i32, i32)*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %res, metadata !33, metadata !11), !dbg !34
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %pf, metadata !35, metadata !11), !dbg !38
  %call = call i32 (...) @nondet_int(), !dbg !39
  %tobool = icmp ne i32 %call, 0, !dbg !39
  br i1 %tobool, label %if.then, label %if.else, !dbg !41

if.then:                                          ; preds = %entry
  store i32 (i32, i32)* @f1, i32 (i32, i32)** %pf, align 8, !dbg !42
  br label %if.end, !dbg !43

if.else:                                          ; preds = %entry
  store i32 (i32, i32)* @f2, i32 (i32, i32)** %pf, align 8, !dbg !44
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %pf, align 8, !dbg !45
  %call1 = call i32 %0(i32 4, i32 3), !dbg !45
  store i32 %call1, i32* %res, align 4, !dbg !46
  %1 = load i32, i32* %res, align 4, !dbg !47
  %cmp = icmp slt i32 %1, 10, !dbg !48
  %conv = zext i1 %cmp to i32, !dbg !48
  %call2 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !49
  %2 = load i32, i32* %res, align 4, !dbg !50
  ret i32 %2, !dbg !51
}

declare i32 @nondet_int(...) #2

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "function_pointer1/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "f1", scope: !1, file: !1, line: 7, type: !7, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9, !9, !9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "a", arg: 1, scope: !6, file: !1, line: 7, type: !9)
!11 = !DIExpression()
!12 = !DILocation(line: 7, column: 12, scope: !6)
!13 = !DILocalVariable(name: "b", arg: 2, scope: !6, file: !1, line: 7, type: !9)
!14 = !DILocation(line: 7, column: 19, scope: !6)
!15 = !DILocation(line: 9, column: 10, scope: !6)
!16 = !DILocation(line: 9, column: 12, scope: !6)
!17 = !DILocation(line: 9, column: 11, scope: !6)
!18 = !DILocation(line: 9, column: 13, scope: !6)
!19 = !DILocation(line: 9, column: 3, scope: !6)
!20 = distinct !DISubprogram(name: "f2", scope: !1, file: !1, line: 12, type: !7, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!21 = !DILocalVariable(name: "x", arg: 1, scope: !20, file: !1, line: 12, type: !9)
!22 = !DILocation(line: 12, column: 12, scope: !20)
!23 = !DILocalVariable(name: "y", arg: 2, scope: !20, file: !1, line: 12, type: !9)
!24 = !DILocation(line: 12, column: 19, scope: !20)
!25 = !DILocation(line: 14, column: 10, scope: !20)
!26 = !DILocation(line: 14, column: 12, scope: !20)
!27 = !DILocation(line: 14, column: 11, scope: !20)
!28 = !DILocation(line: 14, column: 13, scope: !20)
!29 = !DILocation(line: 14, column: 3, scope: !20)
!30 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 17, type: !31, isLocal: false, isDefinition: true, scopeLine: 18, isOptimized: false, unit: !0, variables: !2)
!31 = !DISubroutineType(types: !32)
!32 = !{!9}
!33 = !DILocalVariable(name: "res", scope: !30, file: !1, line: 19, type: !9)
!34 = !DILocation(line: 19, column: 7, scope: !30)
!35 = !DILocalVariable(name: "pf", scope: !30, file: !1, line: 20, type: !36)
!36 = !DIDerivedType(tag: DW_TAG_typedef, name: "FuncType", file: !1, line: 5, baseType: !37)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!38 = !DILocation(line: 20, column: 12, scope: !30)
!39 = !DILocation(line: 22, column: 7, scope: !40)
!40 = distinct !DILexicalBlock(scope: !30, file: !1, line: 22, column: 7)
!41 = !DILocation(line: 22, column: 7, scope: !30)
!42 = !DILocation(line: 23, column: 8, scope: !40)
!43 = !DILocation(line: 23, column: 5, scope: !40)
!44 = !DILocation(line: 25, column: 8, scope: !40)
!45 = !DILocation(line: 27, column: 9, scope: !30)
!46 = !DILocation(line: 27, column: 7, scope: !30)
!47 = !DILocation(line: 29, column: 10, scope: !30)
!48 = !DILocation(line: 29, column: 14, scope: !30)
!49 = !DILocation(line: 29, column: 3, scope: !30)
!50 = !DILocation(line: 31, column: 10, scope: !30)
!51 = !DILocation(line: 31, column: 3, scope: !30)
