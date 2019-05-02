; ModuleID = 'akash_struct_5/main.c'
source_filename = "akash_struct_5/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.QUEUE = type { [15 x i32], i32 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %queue = alloca %struct.QUEUE, align 4
  %n = alloca i32, align 4
  %i = alloca i32, align 4
  %sum = alloca i32, align 4
  %i3 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.QUEUE* %queue, metadata !11, metadata !DIExpression()), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %n, metadata !20, metadata !DIExpression()), !dbg !21
  %0 = load i32, i32* %n, align 4, !dbg !22
  %cmp = icmp slt i32 %0, 15, !dbg !24
  br i1 %cmp, label %if.then, label %if.end, !dbg !25

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %i, metadata !26, metadata !DIExpression()), !dbg !29
  store i32 0, i32* %i, align 4, !dbg !29
  br label %for.cond, !dbg !30

for.cond:                                         ; preds = %for.inc, %if.then
  %1 = load i32, i32* %i, align 4, !dbg !31
  %2 = load i32, i32* %n, align 4, !dbg !33
  %cmp1 = icmp slt i32 %1, %2, !dbg !34
  br i1 %cmp1, label %for.body, label %for.end, !dbg !35

for.body:                                         ; preds = %for.cond
  %3 = load i32, i32* %i, align 4, !dbg !36
  %data = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 0, !dbg !38
  %4 = load i32, i32* %i, align 4, !dbg !39
  %idxprom = sext i32 %4 to i64, !dbg !40
  %arrayidx = getelementptr inbounds [15 x i32], [15 x i32]* %data, i64 0, i64 %idxprom, !dbg !40
  store i32 %3, i32* %arrayidx, align 4, !dbg !41
  %size = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 1, !dbg !42
  %5 = load i32, i32* %size, align 4, !dbg !43
  %inc = add nsw i32 %5, 1, !dbg !43
  store i32 %inc, i32* %size, align 4, !dbg !43
  br label %for.inc, !dbg !44

for.inc:                                          ; preds = %for.body
  %6 = load i32, i32* %i, align 4, !dbg !45
  %inc2 = add nsw i32 %6, 1, !dbg !45
  store i32 %inc2, i32* %i, align 4, !dbg !45
  br label %for.cond, !dbg !46, !llvm.loop !47

for.end:                                          ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %sum, metadata !49, metadata !DIExpression()), !dbg !50
  store i32 0, i32* %sum, align 4, !dbg !50
  call void @llvm.dbg.declare(metadata i32* %i3, metadata !51, metadata !DIExpression()), !dbg !53
  store i32 0, i32* %i3, align 4, !dbg !53
  br label %for.cond4, !dbg !54

for.cond4:                                        ; preds = %for.inc10, %for.end
  %7 = load i32, i32* %i3, align 4, !dbg !55
  %8 = load i32, i32* %n, align 4, !dbg !57
  %cmp5 = icmp slt i32 %7, %8, !dbg !58
  br i1 %cmp5, label %for.body6, label %for.end12, !dbg !59

for.body6:                                        ; preds = %for.cond4
  %data7 = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 0, !dbg !60
  %9 = load i32, i32* %i3, align 4, !dbg !62
  %idxprom8 = sext i32 %9 to i64, !dbg !63
  %arrayidx9 = getelementptr inbounds [15 x i32], [15 x i32]* %data7, i64 0, i64 %idxprom8, !dbg !63
  %10 = load i32, i32* %arrayidx9, align 4, !dbg !63
  %11 = load i32, i32* %sum, align 4, !dbg !64
  %add = add nsw i32 %11, %10, !dbg !64
  store i32 %add, i32* %sum, align 4, !dbg !64
  br label %for.inc10, !dbg !65

for.inc10:                                        ; preds = %for.body6
  %12 = load i32, i32* %i3, align 4, !dbg !66
  %inc11 = add nsw i32 %12, 1, !dbg !66
  store i32 %inc11, i32* %i3, align 4, !dbg !66
  br label %for.cond4, !dbg !67, !llvm.loop !68

for.end12:                                        ; preds = %for.cond4
  %13 = load i32, i32* %sum, align 4, !dbg !70
  %14 = load i32, i32* %n, align 4, !dbg !71
  %sub = sub nsw i32 %14, 1, !dbg !72
  %15 = load i32, i32* %n, align 4, !dbg !73
  %mul = mul nsw i32 %sub, %15, !dbg !74
  %div = sdiv i32 %mul, 2, !dbg !75
  %cmp13 = icmp eq i32 %13, %div, !dbg !76
  %conv = zext i1 %cmp13 to i32, !dbg !76
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !77
  br label %if.end, !dbg !78

if.end:                                           ; preds = %for.end12, %entry
  ret i32 0, !dbg !79
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "akash_struct_5/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !8, scopeLine: 14, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "queue", scope: !7, file: !1, line: 15, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "QUEUE", file: !1, line: 5, size: 512, elements: !13)
!13 = !{!14, !18}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !12, file: !1, line: 7, baseType: !15, size: 480)
!15 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 480, elements: !16)
!16 = !{!17}
!17 = !DISubrange(count: 15)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "size", scope: !12, file: !1, line: 8, baseType: !10, size: 32, offset: 480)
!19 = !DILocation(line: 15, column: 15, scope: !7)
!20 = !DILocalVariable(name: "n", scope: !7, file: !1, line: 16, type: !10)
!21 = !DILocation(line: 16, column: 6, scope: !7)
!22 = !DILocation(line: 20, column: 5, scope: !23)
!23 = distinct !DILexicalBlock(scope: !7, file: !1, line: 20, column: 5)
!24 = !DILocation(line: 20, column: 6, scope: !23)
!25 = !DILocation(line: 20, column: 5, scope: !7)
!26 = !DILocalVariable(name: "i", scope: !27, file: !1, line: 22, type: !10)
!27 = distinct !DILexicalBlock(scope: !28, file: !1, line: 22, column: 3)
!28 = distinct !DILexicalBlock(scope: !23, file: !1, line: 21, column: 2)
!29 = !DILocation(line: 22, column: 11, scope: !27)
!30 = !DILocation(line: 22, column: 7, scope: !27)
!31 = !DILocation(line: 22, column: 17, scope: !32)
!32 = distinct !DILexicalBlock(scope: !27, file: !1, line: 22, column: 3)
!33 = !DILocation(line: 22, column: 19, scope: !32)
!34 = !DILocation(line: 22, column: 18, scope: !32)
!35 = !DILocation(line: 22, column: 3, scope: !27)
!36 = !DILocation(line: 24, column: 20, scope: !37)
!37 = distinct !DILexicalBlock(scope: !32, file: !1, line: 23, column: 3)
!38 = !DILocation(line: 24, column: 10, scope: !37)
!39 = !DILocation(line: 24, column: 15, scope: !37)
!40 = !DILocation(line: 24, column: 4, scope: !37)
!41 = !DILocation(line: 24, column: 18, scope: !37)
!42 = !DILocation(line: 25, column: 12, scope: !37)
!43 = !DILocation(line: 25, column: 4, scope: !37)
!44 = !DILocation(line: 26, column: 3, scope: !37)
!45 = !DILocation(line: 22, column: 24, scope: !32)
!46 = !DILocation(line: 22, column: 3, scope: !32)
!47 = distinct !{!47, !35, !48}
!48 = !DILocation(line: 26, column: 3, scope: !27)
!49 = !DILocalVariable(name: "sum", scope: !28, file: !1, line: 28, type: !10)
!50 = !DILocation(line: 28, column: 7, scope: !28)
!51 = !DILocalVariable(name: "i", scope: !52, file: !1, line: 30, type: !10)
!52 = distinct !DILexicalBlock(scope: !28, file: !1, line: 30, column: 3)
!53 = !DILocation(line: 30, column: 11, scope: !52)
!54 = !DILocation(line: 30, column: 7, scope: !52)
!55 = !DILocation(line: 30, column: 17, scope: !56)
!56 = distinct !DILexicalBlock(scope: !52, file: !1, line: 30, column: 3)
!57 = !DILocation(line: 30, column: 19, scope: !56)
!58 = !DILocation(line: 30, column: 18, scope: !56)
!59 = !DILocation(line: 30, column: 3, scope: !52)
!60 = !DILocation(line: 32, column: 17, scope: !61)
!61 = distinct !DILexicalBlock(scope: !56, file: !1, line: 31, column: 3)
!62 = !DILocation(line: 32, column: 22, scope: !61)
!63 = !DILocation(line: 32, column: 11, scope: !61)
!64 = !DILocation(line: 32, column: 8, scope: !61)
!65 = !DILocation(line: 33, column: 3, scope: !61)
!66 = !DILocation(line: 30, column: 24, scope: !56)
!67 = !DILocation(line: 30, column: 3, scope: !56)
!68 = distinct !{!68, !59, !69}
!69 = !DILocation(line: 33, column: 3, scope: !52)
!70 = !DILocation(line: 35, column: 10, scope: !28)
!71 = !DILocation(line: 35, column: 19, scope: !28)
!72 = !DILocation(line: 35, column: 20, scope: !28)
!73 = !DILocation(line: 35, column: 24, scope: !28)
!74 = !DILocation(line: 35, column: 23, scope: !28)
!75 = !DILocation(line: 35, column: 26, scope: !28)
!76 = !DILocation(line: 35, column: 14, scope: !28)
!77 = !DILocation(line: 35, column: 3, scope: !28)
!78 = !DILocation(line: 36, column: 2, scope: !28)
!79 = !DILocation(line: 38, column: 2, scope: !7)
