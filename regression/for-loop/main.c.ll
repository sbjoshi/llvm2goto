; ModuleID = 'for-loop/main.c'
source_filename = "for-loop/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %z = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !10, metadata !11), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %x, metadata !13, metadata !11), !dbg !14
  call void @llvm.dbg.declare(metadata i32* %y, metadata !15, metadata !11), !dbg !16
  store i32 0, i32* %y, align 4, !dbg !16
  call void @llvm.dbg.declare(metadata i32* %z, metadata !17, metadata !11), !dbg !18
  store i32 0, i32* %z, align 4, !dbg !18
  store i32 0, i32* %i, align 4, !dbg !19
  br label %for.cond, !dbg !21

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !22
  %cmp = icmp slt i32 %0, 1000, !dbg !25
  br i1 %cmp, label %for.body, label %for.end, !dbg !26

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %x, align 4, !dbg !28
  %tobool = icmp ne i32 %1, 0, !dbg !28
  br i1 %tobool, label %if.then, label %if.else, !dbg !31

if.then:                                          ; preds = %for.body
  %2 = load i32, i32* %y, align 4, !dbg !32
  %inc = add nsw i32 %2, 1, !dbg !32
  store i32 %inc, i32* %y, align 4, !dbg !32
  br label %if.end, !dbg !33

if.else:                                          ; preds = %for.body
  %3 = load i32, i32* %z, align 4, !dbg !34
  %inc1 = add nsw i32 %3, 1, !dbg !34
  store i32 %inc1, i32* %z, align 4, !dbg !34
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc, !dbg !35

for.inc:                                          ; preds = %if.end
  %4 = load i32, i32* %i, align 4, !dbg !36
  %inc2 = add nsw i32 %4, 1, !dbg !36
  store i32 %inc2, i32* %i, align 4, !dbg !36
  br label %for.cond, !dbg !38, !llvm.loop !39

for.end:                                          ; preds = %for.cond
  %5 = load i32, i32* %x, align 4, !dbg !42
  %cmp3 = icmp ne i32 %5, 0, !dbg !43
  br i1 %cmp3, label %land.lhs.true, label %lor.rhs, !dbg !44

land.lhs.true:                                    ; preds = %for.end
  %6 = load i32, i32* %y, align 4, !dbg !45
  %cmp4 = icmp eq i32 %6, 1000, !dbg !47
  br i1 %cmp4, label %lor.end, label %lor.rhs, !dbg !48

lor.rhs:                                          ; preds = %land.lhs.true, %for.end
  %7 = load i32, i32* %x, align 4, !dbg !49
  %cmp5 = icmp eq i32 %7, 0, !dbg !51
  br i1 %cmp5, label %land.rhs, label %land.end, !dbg !52

land.rhs:                                         ; preds = %lor.rhs
  %8 = load i32, i32* %z, align 4, !dbg !53
  %cmp6 = icmp eq i32 %8, 1000, !dbg !55
  br label %land.end

land.end:                                         ; preds = %land.rhs, %lor.rhs
  %9 = phi i1 [ false, %lor.rhs ], [ %cmp6, %land.rhs ]
  br label %lor.end, !dbg !56

lor.end:                                          ; preds = %land.end, %land.lhs.true
  %10 = phi i1 [ true, %land.lhs.true ], [ %9, %land.end ]
  %lor.ext = zext i1 %10 to i32, !dbg !58
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %lor.ext), !dbg !60
  %11 = load i32, i32* %retval, align 4, !dbg !61
  ret i32 %11, !dbg !61
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "for-loop/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !7, isLocal: false, isDefinition: true, scopeLine: 4, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "i", scope: !6, file: !1, line: 5, type: !9)
!11 = !DIExpression()
!12 = !DILocation(line: 5, column: 7, scope: !6)
!13 = !DILocalVariable(name: "x", scope: !6, file: !1, line: 5, type: !9)
!14 = !DILocation(line: 5, column: 9, scope: !6)
!15 = !DILocalVariable(name: "y", scope: !6, file: !1, line: 5, type: !9)
!16 = !DILocation(line: 5, column: 11, scope: !6)
!17 = !DILocalVariable(name: "z", scope: !6, file: !1, line: 5, type: !9)
!18 = !DILocation(line: 5, column: 15, scope: !6)
!19 = !DILocation(line: 6, column: 8, scope: !20)
!20 = distinct !DILexicalBlock(scope: !6, file: !1, line: 6, column: 3)
!21 = !DILocation(line: 6, column: 7, scope: !20)
!22 = !DILocation(line: 6, column: 11, scope: !23)
!23 = !DILexicalBlockFile(scope: !24, file: !1, discriminator: 2)
!24 = distinct !DILexicalBlock(scope: !20, file: !1, line: 6, column: 3)
!25 = !DILocation(line: 6, column: 12, scope: !23)
!26 = !DILocation(line: 6, column: 3, scope: !27)
!27 = !DILexicalBlockFile(scope: !20, file: !1, discriminator: 2)
!28 = !DILocation(line: 8, column: 8, scope: !29)
!29 = distinct !DILexicalBlock(scope: !30, file: !1, line: 8, column: 8)
!30 = distinct !DILexicalBlock(scope: !24, file: !1, line: 7, column: 3)
!31 = !DILocation(line: 8, column: 8, scope: !30)
!32 = !DILocation(line: 9, column: 7, scope: !29)
!33 = !DILocation(line: 9, column: 6, scope: !29)
!34 = !DILocation(line: 11, column: 7, scope: !29)
!35 = !DILocation(line: 12, column: 3, scope: !30)
!36 = !DILocation(line: 6, column: 16, scope: !37)
!37 = !DILexicalBlockFile(scope: !24, file: !1, discriminator: 4)
!38 = !DILocation(line: 6, column: 3, scope: !37)
!39 = distinct !{!39, !40, !41}
!40 = !DILocation(line: 6, column: 3, scope: !20)
!41 = !DILocation(line: 12, column: 3, scope: !20)
!42 = !DILocation(line: 13, column: 11, scope: !6)
!43 = !DILocation(line: 13, column: 12, scope: !6)
!44 = !DILocation(line: 13, column: 16, scope: !6)
!45 = !DILocation(line: 13, column: 19, scope: !46)
!46 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 2)
!47 = !DILocation(line: 13, column: 20, scope: !46)
!48 = !DILocation(line: 13, column: 26, scope: !46)
!49 = !DILocation(line: 13, column: 30, scope: !50)
!50 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 4)
!51 = !DILocation(line: 13, column: 31, scope: !50)
!52 = !DILocation(line: 13, column: 35, scope: !50)
!53 = !DILocation(line: 13, column: 38, scope: !54)
!54 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 6)
!55 = !DILocation(line: 13, column: 39, scope: !54)
!56 = !DILocation(line: 13, column: 26, scope: !57)
!57 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 8)
!58 = !DILocation(line: 13, column: 26, scope: !59)
!59 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 10)
!60 = !DILocation(line: 13, column: 3, scope: !59)
!61 = !DILocation(line: 14, column: 1, scope: !6)
